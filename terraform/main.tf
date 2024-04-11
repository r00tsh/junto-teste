module "keypair-ssm" {
  source = "./modules/keypair"

  key_name = "app"
  tags     = {}
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux_2023_x86.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = module.keypair-ssm.key_name
  iam_instance_profile        = aws_iam_instance_profile.app.id
  subnet_id                   = data.aws_subnet.selected.id
  vpc_security_group_ids      = [aws_security_group.app.id]
  user_data                   = <<EOF
#!/bin/bash
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
EOF

  tags = {
    Name    = "APP Teste version ${var.app_version}"
    Ansible = "app"
  }
}

resource "null_resource" "ansible_provisioner" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = "sleep 1; ansible-playbook -i aws_ec2.yml -e version=$VERSION deployment.yml"
    working_dir = "./ansible"

    environment = {
      VERSION = var.app_version
    }
  }

  depends_on = [aws_instance.app]
}
resource "aws_iam_role" "app" {
  name = "APP"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "mx_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.app.name
}

resource "aws_iam_instance_profile" "app" {
  name = "APP-role"
  role = aws_iam_role.app.name
}

resource "aws_iam_policy" "cloudwacth" {
  name        = "APPCloudWatcg"
  path        = "/"
  description = "Policy for EC2 access CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
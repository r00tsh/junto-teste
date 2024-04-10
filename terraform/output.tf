output "app_ip" {
  description = "Public IP of APP"
  value = aws_instance.app.public_ip
}
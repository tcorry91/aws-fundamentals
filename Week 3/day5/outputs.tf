output "role_arn" { value = aws_iam_role.ec2.arn }
output "instance_profile" { value = aws_iam_instance_profile.ec2.name }
output "public_ip" { value = aws_instance.ec2.public_ip }
output "public_dns" { value = aws_instance.ec2.public_dns }

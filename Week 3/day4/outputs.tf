output "vpc_id" { value = aws_vpc.this.id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "private_subnet_id" { value = aws_subnet.private.id }
output "public_route_table" { value = aws_route_table.public.id }
output "private_route_table" { value = aws_route_table.private.id }
output "igw_id" { value = aws_internet_gateway.igw.id }

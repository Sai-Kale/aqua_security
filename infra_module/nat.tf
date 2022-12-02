#########  NAT Gateway for the VPC ##########


resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
#  count         = length(aws_subnet.public_subnet)
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.main-gw]
}

# Private route table
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "${var.app_name}-private-route-table"
  }
}

# route table associations private
resource "aws_route_table_association" "main-private-1-a" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.main-private.id
}

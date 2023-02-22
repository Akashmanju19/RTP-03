
//creating a VPC
resource "aws_vpc" "rtp03-vpc" {
    cidr_block = var.vpc
    tags = {
      Name = "rpt03-vpc"
    }
  
}

// Creatomg a Subnet 
resource "aws_subnet" "rtp03-public_subnet_01" {
    vpc_id = "${aws_vpc.rtp03-vpc.id}"
    cidr_block = var.subnet
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "rtp03-public_subnet_01"
    }
  
}

//Creating a Internet Gateway 
resource "aws_internet_gateway" "rtp03-igw" {
    vpc_id = "${aws_vpc.rtp03-vpc.id}"
    tags = {
      Name = "rtp03-igw"
    }
}

// Create a route table 
resource "aws_route_table" "rtp03-public-rt" {
    vpc_id = "${aws_vpc.rtp03-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.rtp03-igw.id}"
    }
    tags = {
      Name = "rtp03-public-rt"
    }
}

// Associate subnet with routetable 

resource "aws_route_table_association" "rtp03-rta-public-subnet-1" {
    subnet_id = "${aws_subnet.rtp03-public_subnet_01.id}"
    route_table_id = "${aws_route_table.rtp03-public-rt.id}"
  
}
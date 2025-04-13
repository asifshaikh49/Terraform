# ☁️ AWS Infrastructure with Terraform – S3, VPC, Subnet, Load Balancer, EC2 🏗️

## 📦 Overview

In this guide, you'll learn how to create **real AWS resources** using Terraform, including:

- 🗃️ S3 Bucket
- 🌐 VPC (Virtual Private Cloud)
- 📶 Subnets (Public & Private)
- ⚖️ Load Balancer (Application Load Balancer)
- 💻 EC2 Instances
- 🔒 Security Groups

---

## 🛠️ Prerequisites

- AWS account with Access Key & Secret Key 🔑
- Terraform installed on your machine 💻
- IAM permissions to manage VPC, EC2, S3, etc. 🛡️

---

## 📁 Project Structure

```
aws-project/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

---

## 1️⃣ VPC

```hcl
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}
```

---

## 2️⃣ Subnets (Public & Private)

```hcl
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet"
  }
}
```

---

## 3️⃣ Internet Gateway & Route Table

```hcl
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-gw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
```

---

## 4️⃣ S3 Bucket

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-demo-bucket-123"
  acl    = "private"

  tags = {
    Name = "my-bucket"
  }
}
```

---

## 5️⃣ Security Group

```hcl
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---

## 6️⃣ EC2 Instance

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "web-instance"
  }
}
```

---

## 7️⃣ Application Load Balancer

```hcl
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id]
  security_groups    = [aws_security_group.web_sg.id]

  tags = {
    Name = "app-lb"
  }
}
```

---

## 📦 How to Use This Project

```bash
terraform init       # 📦 Setup Terraform
terraform plan       # 🔍 Preview changes
terraform apply      # 🚀 Create infrastructure
terraform destroy    # 💥 Delete everything
```

---

## ✅ Outputs (Optional)

```hcl
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}
```

---

## 💡 Tips

- Always destroy resources after testing to avoid charges! 💸  
- Use `terraform.tfvars` for sensitive inputs 🔐  
- You can extend this by adding RDS, Auto Scaling, etc. 🔄  

---

🌈 **Enjoy building powerful cloud setups with Terraform!**

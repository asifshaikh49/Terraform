# 🌍 Terraform Guide for Beginners 🚀

## 🧠 What is Terraform?

**Terraform** is an open-source tool 🛠️ made by **HashiCorp**. It helps you to:
- Build 🧱
- Change 🔄
- Manage ☁️ cloud infrastructure safely and efficiently 💯.

You define your infrastructure using **code** (Infrastructure as Code = IaC) 📜.

---

## ⚙️ Why Use Terraform?

✅ Automate infrastructure setup  
✅ Use same code for different environments  
✅ Version control your infra using Git  
✅ Easy to understand syntax (HCL)  
✅ Works with AWS, Azure, GCP, and more 🌐

---

## 📦 How Terraform Works

1. **Write Code** – Use `.tf` files to describe infrastructure 💻  
2. **Initialize** – Setup Terraform to download providers 📥  
3. **Plan** – Preview what Terraform will do 🧠  
4. **Apply** – Create/update real infrastructure 🚧  
5. **Destroy** – Remove infrastructure when done 🧹

---

## 🔧 Basic Terraform Commands

```bash
terraform init       # 📦 Initializes project
terraform plan       # 🔍 Shows what will happen
terraform apply      # ✅ Applies the changes
terraform destroy    # 💥 Destroys infra
terraform validate   # ✅ Validates code syntax
terraform fmt        # 🎨 Auto-formats code
```

---

## 📁 File Structure Example

```
my-project/
├── main.tf      # Core infra code
├── variables.tf # Inputs for customization
├── outputs.tf   # Outputs after apply
└── terraform.tfvars # Actual values for variables
```

---

## 🌍 Providers (Example: AWS)

```hcl
provider "aws" {
  region = "us-east-1"
  access_key = "your-access-key"
  secret_key = "your-secret-key"
}
```

---

## 🏗️ Resource Example (Create EC2 in AWS)

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance"
  }
}
```

---

## 🌈 Using Variables

```hcl
variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = var.instance_type
}
```

Use with `terraform.tfvars`:
```hcl
instance_type = "t3.micro"
```

---

## 💬 Output Example

```hcl
output "instance_id" {
  value = aws_instance.example.id
}
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


## 🧪 Real Project Steps (AWS Example)

1. ✅ Create an AWS account  
2. 🔐 Setup IAM User with Access Keys  
3. 💻 Install Terraform  
4. 🏗️ Create project folder & files (`main.tf`, `variables.tf`, etc.)  
5. 📦 Run `terraform init`  
6. 🔍 Run `terraform plan`  
7. 🚀 Run `terraform apply`  
8. 🧹 When done, run `terraform destroy` to clean up

---

## 🌐 Use with Cloud Providers

✅ AWS  
✅ Azure  
✅ Google Cloud  
✅ DigitalOcean  
✅ Oracle Cloud  
✅ Kubernetes  
✅ GitHub (for repo automation)

---

## 📚 Extra Features

- **State File (`terraform.tfstate`)** – stores real infra status
- **Remote Backends** – store state in S3, GitHub, etc.
- **Modules** – reusable infrastructure blocks
- **Workspaces** – separate environments (dev, prod)

---

## 🛑 Best Practices

✅ Use `.tfvars` for secrets and inputs  
✅ Never commit `terraform.tfstate` file  
✅ Format using `terraform fmt`  
✅ Use version control (Git)  
✅ Use modules for big projects

---

## 📘 Learning Resources

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [Awesome Terraform GitHub Repo](https://github.com/shuaibiyy/awesome-terraform)
- Free courses on YouTube, HashiCorp, Udemy, etc.

---

## 🤖 Final Words

Terraform helps you become a DevOps Hero! 🦸‍♂️  
With just code, you can control the cloud like a wizard 🧙‍♂️.

> "Don’t click it, **code it**!" 💻✨

---

📁 This README is beginner-friendly. You can now start building your own cloud infra using Terraform! 🚀

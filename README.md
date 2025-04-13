# Manually combining the Terraform basic guide and AWS project guide into one complete markdown content

combined_terraform_readme = f"""
# 🌍 Complete Terraform Guide 🚀

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

# Azure Cloud Shell - Quick Notes

## 1. Overview & Purpose
* **Definition:** An interactive, browser-accessible, authenticated shell environment for managing Azure resources without local tool installation.
* **Key Benefit:** Pre-authenticated via the current Azure portal session, providing an instant working environment.

## 2. Shell Environments
* **Bash (Linux/Ubuntu):** Primary recommendation. Native environment for DevOps tooling (Terraform, Git, Azure CLI).
* **PowerShell:** Alternative environment for running Azure `Az` PowerShell cmdlets.

## 3. Pre-installed Tooling (DevOps Ready)
* **CLI & SDKs:** Azure CLI (`az`) and Azure PowerShell (`Az`).
* **Infrastructure as Code:** Terraform (ready for testing configurations without local setup).
* **Version Control:** Git.
* **Editor:** Built-in web-based VS Code via `code .` command for editing scripts and `.tf` files.

## 4. Storage & Data Persistence (`clouddrive`)
* Cloud Shell runs on a temporary container.
* Requires an underlying **Azure Storage Account** and File Share to persist user files across sessions.
* Files saved in the `clouddrive` directory survive container restarts and termination.

## 5. Quick Reference Commands
* Launch VS Code editor in current directory: `code .`
* Check Terraform version: `terraform version`
* Access directly via web: [shell.azure.com](https://shell.azure.com)
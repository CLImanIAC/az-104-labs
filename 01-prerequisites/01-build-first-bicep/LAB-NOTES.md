# Lab 01: Build Your First Bicep Template

## 🎯 Objectives
* Write a declarative Bicep template to provision an Azure Storage Account.
* Configure Infrastructure as Code (IaC) workspace structure and sync it with GitHub.
* Deploy resources using Azure CLI (`az deployment group create`).

## 🛠️ Resources Created & Configured
* **Resource Group:** `rg-bicep` 
* **Target Region:** `Sweden Central`
* **Storage Account:** `bicepstore1337`
* **SKU / Tier:** Standard_LRS / Hot (StorageV2)

## 🚀 Execution Commands Used
```powershell
# 1. Authenticate with Azure
az login

# 2. Deploy Bicep template to existing resource group
az deployment group create --resource-group rg-bicep --template-file 01-prerequisites/01-build-first-bicep/main.bicep

# 3. Verify deployment history in table format
az deployment group list --resource-group rg-bicep --output table

# 4. List all deployed resources within the resource group cleanly via CLI
az resource list --resource-group rg-bicep --query "[].{Name:name, Type:type}" --output table
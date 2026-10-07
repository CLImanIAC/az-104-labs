## 🚀 Execution Commands Used

**1. Create resource group**
```powershell
az group create --name rg-bicep --location swedencentral
```
**2. Deploy the Bicep template with the parameters file**
```powershell
az deployment group create --name main --resource-group rg-bicep --template-file D:\Azure\01-prerequisites\02-build-reusable-bicep\02-add-parameter-file-and-secure-parameters\main.bicep --parameters D:\Azure\01-prerequisites\02-build-reusable-bicep\02-add-parameter-file-and-secure-parameters\main.parameters.dev.json
```

**3.Create a key vault and secrets.**
```bash
keyVaultName='kv-rg-bicep-dev'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password
az keyvault create --name $keyVaultName --location eastus --enabled-for-template-deployment true
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none
```
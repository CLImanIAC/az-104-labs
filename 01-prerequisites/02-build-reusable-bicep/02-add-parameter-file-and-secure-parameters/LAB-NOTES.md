## 🚀 Execution Commands Used

**1. Create resource group**
```powershell
az group create --name rg-bicep --location swedencentral
```
**2. Deploy the Bicep template with the parameters file (Powershell)**
```powershell
az deployment group create --name main --resource-group rg-bicep --template-file D:\Azure\01-prerequisites\02-build-reusable-bicep\02-add-parameter-file-and-secure-parameters\main.bicep --parameters D:\Azure\01-prerequisites\02-build-reusable-bicep\02-add-parameter-file-and-secure-parameters\main.parameters.dev.json
```

**3. Create a key vault and secrets. (Git Bash)**
```GIT bash
keyVaultName='kv-rg-bicep-dev'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password
az provider register --namespace Microsoft.KeyVault
az provider show --namespace Microsoft.KeyVault --query "registrationState"
az keyvault create --name $keyVaultName --resource-group rg-bicep --location swedencentral --enabled-for-template-deployment true --enable-rbac-authorization false
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none
```
**4. Get the key vault's resource ID (GIT Bash)**
```GIT bash
az keyvault show --name $keyVaultName --query id --output tsv
```
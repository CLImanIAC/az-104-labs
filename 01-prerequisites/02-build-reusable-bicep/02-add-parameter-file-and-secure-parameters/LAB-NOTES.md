## 🚀 Execution Commands Used

**1. Create resource group**
```powershell
az group create --name rg-bicep --location swedencentral
```
**2. Deploy the Bicep template with the parameters file**
```powershell
az deployment group create --name main --template-file main.bicep --parameters main.parameters.dev.json
```
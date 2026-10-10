# Setup & Environment Configuration

**0. Ensure Bicep CLI is up to date:**

```bash
az bicep install && az bicep upgrade
```
**1. Sign in to Azure:**

```powershell
az login
```

**2. Create resource group:**

```powershell
az group create --name rg-bicep --location swedencentral
```

**3. Set default resource group:**

```powershell
az configure --defaults group="rg-bicep"
```
**4. Deploy the template to Azure**

```powershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
```
```powershell
az deployment group create --name $DeploymentName --template-file $templateFile
```
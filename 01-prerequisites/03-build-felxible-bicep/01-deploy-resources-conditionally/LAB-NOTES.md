# Lab Notes: Use Conditions in Bicep

## 🎯 Key Concepts & Takeaways

### 1. Conditional Resource Deployment (`if`)
* Use the `if` keyword directly on a resource declaration to control whether it gets deployed based on specific criteria (e.g., environment names like `Development` vs `Production`)[cite: 1, 2].
* Best practice is to assign the condition logic to a clear boolean variable (e.g., `var auditingEnabled = environmentName == 'Production'`) to make templates easier to read[cite: 2].

### 2. Handling Conditional Dependencies & Ternary Operators (`? :`)
* Azure Resource Manager (ARM) evaluates expressions before checking whether a resource's creation condition evaluates to true[cite: 2].
* When referencing properties or keys of conditionally deployed resources, always use the ternary operator (`? :`) to provide a safe fallback value (such as an empty string `''`) and prevent deployment evaluation errors[cite: 2].

### 3. Best Practices for Naming Constraints
* Always use built-in functions like `take()` when generating names for resources with strict character limits (e.g., restricting storage account names to a maximum of 24 characters)[cite: 2].


## 🚀 Practical Exercise Workflow & Commands

**0. Update bicep**
```powershell
az bicep install && az bicep upgrade
```
**1. Sign in to azure**
```powershell
az login
```
**2. Create resource group**
```powershell
az group create --name rg-bicep --location swedencentral
```
**3. Set default resource group - not needed later to add in commands**
```powershell
az configure --defaults group="rg-bicep"
```
**4. Deploy the Bicep file to Azure - DEV**
```powershell
az deployment group create --name main --template-file 01-prerequisites\03-build-felxible-bicep\01-deploay-resources-conditionally\main.bicep --parameters location=swedencentral
```
**5. Deploy the Bicep file to Azure - PROD**
```powershell
az deployment group create --name main --template-file 01-prerequisites\03-build-felxible-bicep\01-deploay-resources-conditionally\main.bicep --parameters environmentName=Production location=swedencentral
```
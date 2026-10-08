# Lab Notes: Use Conditions and Loops in Bicep

## 🎯 Key Concepts & Takeaways

### 1. Conditional Resource Deployment (`if`)
* Use the `if` keyword directly on a resource declaration to control whether it gets deployed based on specific criteria (e.g., environment names like `Development` vs `Production`).
* Best practice is to assign the condition logic to a clear boolean variable (e.g., `var auditingEnabled = environmentName == 'Production'`) to make templates easier to read.

### 2. Handling Conditional Dependencies & Ternary Operators (`? :`)
* Azure Resource Manager (ARM) evaluates expressions before checking whether a resource's creation condition evaluates to true.
* When referencing properties or keys of conditionally deployed resources, always use the ternary operator (`? :`) to provide a safe fallback value (such as an empty string `''`) and prevent deployment evaluation errors.

### 3. Best Practices for Naming Constraints
* Always use built-in functions like `take()` when generating names for resources with strict character limits (e.g., restricting storage account names to a maximum of 24 characters).

### 4. Iterative Loops (`for`)
* Use the `for` expression in Bicep to define multiple instances of resources, modules, variables, properties, or outputs without duplicating code.
* Loops can iterate over arrays of strings, objects, or integer ranges.
* You can capture the loop index using: `[for (item, i) in collection: { ... }]`.
* Use the `@batchSize(int)` decorator to control concurrency when resources shouldn't all deploy in parallel.

---

## 🚀 Practical Exercise Workflow & Commands

### 0. Setup & Environment Configuration
* **Ensure Bicep CLI is up to date:**
```bash
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
**4. Deploy the Bicep file to Azure**
```powershell
az deployment group create --name main --template-file D:\Azure\01-prerequisites\03-build-felxible-bicep\02-deploy-resource-using-loops\main.bicep
```
## 🧹 Cleanup: Deleting the Resource Group (`rg-bicep`)
To tear down all deployed resources and clean up your Azure environment when you are done practicing:

```powershell
az group delete --name rg-bicep --yes --no-wait
```
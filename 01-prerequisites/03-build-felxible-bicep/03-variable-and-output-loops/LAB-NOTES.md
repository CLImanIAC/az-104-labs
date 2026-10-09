# LAB-NOTES: Advanced Bicep Loops, Variables, and Outputs (Cheat Sheet)

## 1. Controlling Loop Execution (`@batchSize`)
* **Default (Parallel):** Deploys all loop items simultaneously for maximum speed in a non-deterministic order.
* **`@batchSize(n)`:** Processes resources in batches of `n`, waiting for the current batch to fully finish before triggering the next.
* **`@batchSize(1)` (Sequential):** Forces strict one-by-one sequential deployment, waiting for each resource completion before proceeding.

## 2. Resource Property Loops & Nested Loops
* **Resource Property Loops:** Embedding a `for` loop directly inside a resource property block (e.g., dynamically generating child elements like subnets inside a virtual network property array).
* **Nested Loops:** A loop within a loop. Commonly used for multi-region architectures where each regional resource (outer loop) requires multiple child resources or subnets (inner loop) generated via functions like `range()`.

## 3. Variable Loops
* **Purpose:** Dynamically construct and transform complex arrays or objects from simplified user parameters before they are passed into resource declarations.
* **Benefit:** Keeps parameter definitions clean while letting Bicep logic map them into the detailed structure required by Azure resource schemas.

## 4. Output Loops
* **Purpose:** Aggregate and return runtime properties (names, locations, FQDNs) from loop-generated resources or modules back to users or CI/CD pipelines.
* **Syntax Rule:** Because direct resource referencing inside loops isn't supported, output loops require array indexers (`[i]`) to iterate through deployed instances.
* **Security Note:** Never return sensitive data (passwords, connection strings, secrets) through outputs, as deployment outputs are permanently recorded in execution logs.

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
az deployment group create --name main --template-file D:\Azure\01-prerequisites\03-build-felxible-bicep\03-variable-and-output-loops\main.bicep
```
## 🧹 Cleanup: Deleting the Resource Group (`rg-bicep`)
To tear down all deployed resources and clean up your Azure environment when you are done practicing:

```powershell
az group delete --name rg-bicep --yes --no-wait
```
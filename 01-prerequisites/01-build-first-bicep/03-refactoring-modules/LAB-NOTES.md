# Lab Notes: 03 - Refactoring Bicep Code into Modules

## 🎯 Lab Goal
- Deconstruct a monolithic `main.bicep` template into smaller, reusable components (modules).
- Learn infrastructure encapsulation and how to pass parameters between the main template and modules.
- Utilize `output` statements to extract created resource properties (like hostnames) back into the main template.

---

## 📂 Project Structure
    03-refactoring-modules/
    ├── main.bicep                 # Main orchestrator (calls modules and defines global resources like Storage Account)
    └── modules/
        └── appService.bicep       # Dedicated module handling App Service Plan and Web App

---

## 🔑 Key Concepts
- **Modules (`module`):** Allow breaking down large templates into logical units. Each module requires a unique symbolic name and a relative path. Azure treats each module as a separate deployment.
- **Encapsulation:** Modules isolate specific resource logic, keeping the main template clean, manageable, and easy to maintain.

---

## ⚙️ Parameters and Outputs
- **Parameters (`params`):** Used to send data from `main.bicep` down into the module (e.g., `location`, `environmentType`, `appServiceAppName`).
- **Outputs (`output`):** Enable returning data from the module back to `main.bicep` or the deployment results. 
  - *Example:* Retrieving the generated `defaultHostName` via `appService.outputs.appServiceAppHostName`.

---

## 🚀 Deployment Execution
To execute the modular deployment from the project root using Azure CLI:

```powershell
az deployment group create --name main --resource-group rg-bicep --template-file 01-prerequisites/01-build-first-bicep/03-refactoring-modules/main.bicep --parameters environmentType=nonprod

## 🧹 Cleanup: Deleting the Resource Group (`rg-bicep`)
To tear down all deployed resources and clean up your Azure environment when you are done practicing:

```powershell
az group delete --name rg-bicep --yes --no-wait
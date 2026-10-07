# Lab Notes: Build Reusable Bicep Files - Understand Parameters

## 1. Overview & Purpose
* **Definition:** Parameters allow you to pass dynamic values into a Bicep template at deployment time.
* **Core Benefit:** Enables template reusability across different environments (e.g., `dev`, `test`, `prod`) without modifying the core infrastructure code.

## 2. Syntax & Data Types
* **Keyword:** Declared using the `param` keyword.
* **Supported Types:** `string`, `int`, `bool`, `array`, and `object`.
* **Arrays (`array`):** Used to pass a list of values (e.g., a list of subnet prefixes, IP ranges, tags, or environment names). Defined using square brackets `[]` and accessed via index or iterated through using loops in Bicep.
* **Objects (`object`):** Used to pass structured, key-value configurations (e.g., resource settings, VM sizing specs) as a single logical unit.
* **Default Values:** Optional values can be assigned directly during declaration, while environment-specific or critical inputs should require explicit definition.

## 3. Decorators for Validation & Documentation
Decorators (starting with `@`) modify parameter behavior, enforce rules, and add metadata:
* `@description()`: Documents the purpose of the parameter for readability and tooling.
* `@allowed()`: Restricts input to a predefined list of allowed values (acting as an enum).
* `@minValue()` / `@maxValue()`: Sets numerical boundaries for integer parameters.

## 4. Handling Sensitive Data (`@secure()`)
* Used for secrets, passwords, connection strings, or private keys.
* Prevents sensitive values from being exposed in deployment history or console logs.

## 5. Parameter Deployment & Management
* Values can be supplied directly via the CLI during execution.
* For scalability, values are typically managed using separate parameters files (e.g., `.bicepparam` or traditional JSON parameter files) to keep code decoupled from configuration data.

## 6. Parameter Files (`.bicepparam`)
* **Core Purpose (Blueprint vs. Configuration):** Decouples environment-specific data (like SKUs, names, or sizing) from your core Bicep infrastructure code. Think of the `.bicep` file as the architectural blueprint and the `.bicepparam` file as the specific configuration for an environment (e.g., `dev` vs. `prod`), allowing you to reuse the exact same code everywhere without manual editing.
* **Modern Standard:** Native Bicep parameter file format replacing legacy JSON files.
* **Linkage:** Utilizes an explicit `using` statement (e.g., `using './main.bicep'`) to link directly to the target template.
* **IDE Support:** Provides rich autocompletion, real-time type checking, and error validation in VS Code.
* **Deployment via CLI:** Passed using the `--parameters` switch during deployment, simplifying the command line since the target template is already declared inside the file.

## 7. Securing Parameters (`@secure()`)
* **The Plain Text Risk:** Standard parameter files (`.bicepparam` or JSON) and command-line inputs store values in plain text, making them completely unsafe for sensitive data like passwords, API keys, connection strings, or private keys.
* **The `@secure()` Decorator:** Applying the `@secure()` decorator to a parameter tells Azure Resource Manager (ARM) to treat the value as sensitive. This ensures the value is **never logged** or displayed in deployment history, console output, or Azure portal logs.
* **Azure Key Vault Integration (Best Practice):** Secrets should never be hardcoded or passed manually. Instead, secure parameters should be dynamically retrieved at deployment time directly from an **Azure Key Vault** using a Key Vault reference.
* **Secure Outputs:** Sensitive values generated during deployment can also be protected using the `@secure()` decorator on output variables to prevent data leakage in deployment logs.
* 

## 🚀 Execution Commands Used

**1. Create resource group**
```powershell
az group create --name rg-bicep --location swedencentral
```
**
**2. Deploy Bicep template to existing resource group**
```powershell
az deployment group create --resource-group rg-bicep --template-file D:\Azure\01-prerequisites\02-build-reusable-bicep\01-add-parameters-and-decorators\main.bicep
```
# Lab Notes: Build Reusable Bicep Files - Understand Parameters

## 1. Overview & Purpose
* **Definition:** Parameters allow you to pass dynamic values into a Bicep template at deployment time.
* **Core Benefit:** Enables template reusability across different environments (e.g., `dev`, `test`, `prod`) without modifying the core infrastructure code.

## 2. Syntax & Data Types
* **Keyword:** Declared using the `param` keyword.
* **Supported Types:** `string`, `int`, `bool`, `array`, and `object`.
* **Arrays (`array`):** Used to pass a list of values (e.g., a list of subnet prefixes, IP ranges, tags, or environment names). Defined using square brackets `[]` and accessed via index or iterated through using loops in Bicep.
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
* For scalability, values are typically managed using separate parameters files (e.g., `.bicepparam` or JSON parameter files) to keep code decoupled from configuration data.

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
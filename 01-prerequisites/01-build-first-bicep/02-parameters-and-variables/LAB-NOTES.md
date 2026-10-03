# Lab Notes: Parameters and Variables

## Key Learnings:
- **Parameters (`param`)**: Used for external inputs and provide flexibility to the template (can be overridden at deployment time).
- **Variables (`var`)**: Used for internal logic and fixed values within the code that cannot be overridden from the outside.
- **Global Uniqueness**: Resources like Storage Accounts and App Service apps require globally unique names (which is why we use the `uniqueString()` function), whereas internal resources like App Service plans only need names that are unique within their resource group.
# Summary: Allow Users to Reset Their Password (SSPR in Microsoft Entra ID)

This module covers the implementation and management of **Self-Service Password Reset (SSPR)** in Microsoft Entra ID, detailing how users can securely reset expired or forgotten passwords without administrator intervention, thereby reducing help-desk workloads and maximizing productivity.

---

## 1. Introduction & Overview of SSPR
* **Purpose**: Allows users who are not signed in (forgotten or expired passwords) to reset their credentials via a web browser or Windows sign-in screen to regain access to Azure, Microsoft 365, and other Entra ID-integrated applications.
* **Benefits**: Minimizes administrative overhead for IT support staff and reduces user downtime/productivity loss.
* **Requirements**: Requires paid Microsoft Entra subscriptions with P1 or P2 licenses (free or pay-as-you-go subscriptions do not support SSPR) [cite: https://learn.microsoft.com/en-us/training/modules/allow-users-reset-their-password/1-introduction, https://learn.microsoft.com/en-us/training/modules/allow-users-reset-their-password/2-self-service-password-reset]. The administrator configuring it needs at least the **Authentication Policy Administrator** role [cite: https://learn.microsoft.com/en-us/training/modules/allow-users-reset-their-password/1-introduction, https://learn.microsoft.com/en-us/training/modules/allow-users-reset-their-password/3-implement-azure-ad-self-service-password-reset].

---

## 2. How SSPR Works & Authentication Methods
* **Reset Workflow**: 
  1. *Localization* (renders page in the browser's language).
  2. *Verification* (username entry and CAPTCHA challenge).
  3. *Authentication* (user verifies identity via registered methods).
  4. *Password Reset* (enter and confirm a new password).
  5. *Notification* (confirmation message sent to the user).
* **Supported Authentication Methods**:
  * *Mobile app notification* or *Mobile app code* (Microsoft Authenticator).
  * *Email* (external email address).
  * *Mobile phone* (SMS message or automated call).
  * *Office phone* (automated voice call).
  * *Security questions* (pre-configured questions and answers).
* **Best Practices**:
  * Enable at least two authentication methods.
  * Prioritize mobile app notifications/codes over SMS or security questions (which can be vulnerable to social engineering).
  * Administrator accounts always enforce a strict two-method authentication policy, and security questions are disabled for them.

---

## 3. Implementing and Scoping SSPR
* **Rollout Scope Options**:
  * **None**: SSPR is disabled for all users.
  * **Selected**: SSPR is enabled only for members of a specified security group (ideal for pilots/trials).
  * **All**: SSPR is enabled for all users across the organization.
* **Hybrid Deployments & Password Writeback**:
  * For organizations using local Active Directory alongside Microsoft Entra ID, **Password Writeback** can be configured via *Microsoft Entra Connect* or *cloud sync*. This ensures cloud password resets are written back to the on-premises directory.

---

## 4. Notifications, Customization & Directory Branding
* **Notifications**: Administrators can configure alerts to notify users when their passwords are changed and alert all admins when another administrator resets their password.
* **Helpdesk Links**: Custom email addresses or helpdesk URLs can be provided during SSPR setup so users know where to seek assistance.
* **Company Branding**: Custom icons, logos (favicons), background images, and color schemes can be applied under *Company Branding* in Microsoft Entra ID. This reassures users that they are interacting with a legitimate system during sign-in and password reset flows.
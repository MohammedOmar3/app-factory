# <App name> — data inventory

Feeds the privacy policy, App Store privacy labels and Play Data safety. Update in the same PR as any feature that collects data.

| Data | Example | Collected by | Stored in | Linked to user | Purpose | Optional? |
| --- | --- | --- | --- | --- | --- | --- |
| User ID | uuid | Supabase Auth | Supabase | Yes | App functionality | No |
| Email | a@b.com | Supabase Auth (email/Apple/Google sign-in) | Supabase | Yes | Account | Yes |
| Purchase history | pro_annual | RevenueCat | RevenueCat, Supabase entitlements | Yes | App functionality | No |
| Crash data, diagnostics | stack trace, device model | Sentry | Sentry (EU) | Yes (user id) | App functionality | No |

Tracking (ATT): none. Third-party analytics: none. Data sold: no.

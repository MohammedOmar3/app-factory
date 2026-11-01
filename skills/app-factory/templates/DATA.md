# <App name> — data inventory

Feeds the privacy policy, App Store privacy labels and Play Data safety. Update in the same PR as any feature that collects data.

| Data | Example | Collected by | Stored in (processor) | Linked to user | Purpose | Retention | Optional? |
| --- | --- | --- | --- | --- | --- | --- | --- |
| User ID | uuid | Supabase Auth | Supabase | Yes | App functionality | Until account deletion | No |
| Email | a@b.com | Supabase Auth (email/Apple/Google sign-in) | Supabase; Resend sends codes | Yes | Account | Until account deletion | Yes |
| Name | Jane Appleseed | Sign in with Apple (first sign-in only) | Supabase `profiles.display_name` | Yes | Account | Until account deletion | Yes |
| Purchase history | pro_annual | RevenueCat | RevenueCat, Supabase entitlements | Yes | App functionality | As tax law requires; app copy deleted with the account | No |
| Crash data, diagnostics | stack trace, device model | Sentry | Sentry (EU) | Yes (user id) | App functionality | 90 days | No |
| Push token | device token | Expo / APNs / FCM | Supabase | Yes | Reminders the user asked for | Until sign-out or account deletion | Yes |
| Product events | paywall_shown | EAS Observe or Supabase events table | Expo or Supabase | Yes (user id) | App functionality (funnel) | 90 days | No |

Lawful basis: contract (account, purchases, reminders the user asked for), legitimate interest (crash data, funnel events).

Tracking (ATT): none. Third-party analytics: none. Data sold: no.

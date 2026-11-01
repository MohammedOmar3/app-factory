# Business setup (once per account, not per app)

A checklist to verify with official sources; not tax or legal advice. Values come from `app-factory.config.json` `business` (`residence`, `entity`, `euTraderContact`). Record progress in the template repo's docs, not in each app.

## Stores and payouts

- [ ] Apple Developer Program enrolled as the `business.entity` (individual for a sole trader); App Store **Small Business Program** (15% commission instead of 30%)
- [ ] App Store Connect: Paid Apps agreement active, bank account for payouts, tax forms (including the US W-8BEN for non-US sellers)
- [ ] Google Play developer account, payments profile, tax forms, bank account (when Android starts)
- [ ] Play closed-test **tester pool** of 12+ people, reused for every app's 14-day closed test
- [ ] Paddle seller account verified (merchant of record for web purchases; handles sales tax worldwide) and connected to RevenueCat

## Tax and registrations

- [ ] Registrations required where `business.residence` is (for the UAE: check corporate-tax registration duties and thresholds as turnover grows; confirm on the official tax authority's site)
- [ ] Records of store, Paddle and RevenueCat payouts kept per month

## EU Digital Services Act trader status

- [ ] Decide the address, phone and email Apple publishes on the EU App Store page (`business.euTraderContact`). A sole trader's personal details are published unless a business address is used. Decide before the first EU launch.

## Data processing agreements

- [ ] Accepted (usually a dashboard click or terms page) with: Supabase, Sentry, RevenueCat, Resend, Paddle, and the image-generation provider if user data is ever sent to it

## Legal review

- [ ] Once an app earns: one-time lawyer review of the privacy policy and terms templates

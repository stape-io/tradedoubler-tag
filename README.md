# Tradedoubler Tag for Google Tag Manager Server-Side

The **Tradedoubler Tag for GTM Server-Side** enables server-to-server (S2S) tracking by sending events to Tradedoubler’s conversion tracking endpoint. It supports event types for **Page View**, **User Data**, and **Conversion** with options to manage cookies, send hashed user identifiers, and include product-level tracking data.

## How to Use

1. Add the **Tradedoubler Tag** to your Server GTM container.
2. Select the **Event Type**:
   - **Page View** — Stores Click ID (`tduid`) and Cashback Click ID (`tdclid_sn`) from the URL into cookies.
   - **User Data** — Sends hashed identifiers such as email or user ID for user matching.
   - **Conversion** — Sends conversion details to Tradedoubler, including optional product-level data.
3. For **Page View** events:
   - Configure the parameter names for Click IDs (`tduid`, `tdclid_sn`) if different from the defaults.
   - Optionally set cookie expiration (days), domain, and HttpOnly flag.

   > ℹ️ The `tduid` is a click identifier that contains rich information about the click and is Tradedoubler’s most accurate form of tracking.
   > The `tdclid_sn` is a tracking identifier used by cashback and loyalty publishers.

4. For **User Data** events:
   - Provide a user identifier such as **email**, **user ID**, or **device ID**.
   - Optionally provide **Device ID** and redact IP address.
5. For **Conversion** events:
   - Provide **Event ID**, **Conversion Type**, and either **Organization ID** or the combination of **Program ID** and **Publisher Site ID**.
   - Provide the **Order/Lead Number** and **Order Value** (for `sales`).
   - Optionally provide **Currency**, **Voucher**, **Product List**, and Click IDs (`tduid`, `tdclid_sn`).
   - Enable **Product Level Tracking (PLT)** for sending detailed product information.
6. Configure **Consent Settings** to control whether data is sent always or only if marketing consent is given.
7. Optionally enable **Logging**:
   - Console logs during preview/debug or always.
   - BigQuery logs for storing event data in your Google Cloud project.

## Required Fields

- For **Page View**:
  - **Click ID URL Parameter** (default: `tduid`)
  - **Cashback Click ID URL Parameter** (default: `tdclid_sn`)
- For **User Data**:
  - **Organization ID**
  - At least one of the following: **hashed email**, **hashed user ID**, or **device ID**
- For **Conversion**:
  - **Organization ID**, or both **Program ID** and **Publisher Site ID**
  - **Event ID**
  - **Conversion Type** (`sales` or `leads`)
  - **Order/Lead Number**
  - **Order Value** (for `sales`)
  - **Currency** (for `sales`)
  - If **PLT** is enabled:
    - Each product must contain the required fields depending on the PLT mode.

## Important Notes

- **SHA-256 hashing** is automatically applied to email and user ID if not pre-hashed.
- **PLT** (Product Level Tracking) requires a specific object structure with identifiers and product details.
- **Redact IP** feature ensures user IP address is not sent if enabled.
- **Avoid double-tracking**: do not use this tag together with Tradedoubler client-side pixels.

## Benefits of Using Server-Side Tracking with Tradedoubler

- ✅ **Reliable Attribution** — Server-side postbacks are not blocked by browsers or extensions.
- 🔒 **Improved Privacy** — Send only hashed identifiers; redact IP addresses if required.
- 🛍️ **Detailed Reporting** — Support for order-level and product-level revenue tracking.
- ⚡ **Fast Execution** — Optional optimistic scenario for quicker tag completion.

## Open Source

The **Tradedoubler Tag for GTM Server-Side** is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.

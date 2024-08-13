# How to use MoneyHash V2 iOS

Welcome to the MoneyHash SDK documentation! This document provides an overview of the core functionalities available in the MoneyHash SDK, focusing on intent states, API methods, and models.

---

### Intent States Documentation

In the MoneyHash SDK, intents can exist in various states, each requiring specific actions to be completed. Below is a summary of the different intent states and the actions associated with them.

#### Intent States and Corresponding Actions

| State                             | Action                                                                                                                                                                                                                                                             |
| :-------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `methodSelection(methods: IntentMethods?)`                | [Handle this state](#how-to-handle-method-selection) by rendering the payment methods provided in `methods` directly in your UI for user selection. After the user selects a method, proceed with the method by calling [`moneyHashSDK.proceedWithMethod`](./APIsDocs.md#6-proceed-with-selected-method).                                                                                                  |
| `formFields(tokenizeCardInfo: TokenizeCardInfo?, billingFields: [InputField]?, shippingFields: [InputField]?)`  | [Handle this state](#handling-the-formfields-state) by rendering the form fields provided in the `billingFields`, `shippingFields`, and `tokenizeCardInfo`. These fields should be displayed natively in your UI. Once the user completes the form, submit the data using [`moneyHashSDK.submitForm`](./APIsDocs.md#7-submit-form).                        |
| `redirectToURL(url: String?, renderStrategy: RenderStrategy?)`  | Render the MoneyHash embed form using the [`moneyHashSDK.renderForm`](./APIsDocs.md#1-render-moneyhash-embed-form) method. This will let MoneyHash handle the payments for you. Use the `completionHandler` to track the result of the form submission, including success or failure.                                                                                             |
| `savedCardCVV(cvvField: InputField, cardTokenData: CardTokenData?)` | Render a CVV input field using the schema received in `cvvField`. You can also display basic card information from [`cardTokenData`](./ModelsDocs.md#31-cardtokendata). Once the CVV is entered by the user, submit it using [`moneyHashSDK.submitCardCVV`](./APIsDocs.md#8-submit-card-cvv).                                          |
| `intentForm`                     | Render the MoneyHash embed form using the [`moneyHashSDK.renderForm`](./APIsDocs.md#1-render-moneyhash-embed-form) method. This will let MoneyHash handle the payments for you. Use the `completionHandler` to track the result of the form submission, including success or failure.                               |
| `intentProcessed`                | Render a success confirmation UI with the intent details provided. This indicates that the payment or payout has been successfully completed.                                                                                                                        |
| `transactionWaitingUserAction`   | Display a UI indicating that the transaction is waiting for user action. If available, display any external action message from `Transaction` that the user needs to complete.                                                                                       |
| `transactionFailed(recommendedMethods: IntentMethods?)`   | Render a failure UI indicating that the transaction has failed. If `recommendedMethods` are provided, display these methods as alternative options for the user to retry the payment or payout.                                                                  |
| `expired`                        | Display a UI indicating that the intent has expired. The user will need to initiate a new transaction.                                                                                                                                                             |
| `closed`                         | Display a UI indicating that the intent has been closed. No further actions can be taken for this intent.                                                                                                                                                          |


---
### How to Handle Method Selection

Handling method selection in MoneyHash involves a few key steps:

1. **Render the Methods with Your Own UI:**
   Render the payment methods in your application using your preferred UI components.

2. **When the User Selects a Method:**
   Use the [Proceed with Selected Method](./APIsDocs.md#6-proceed-with-selected-method) API to proceed with the method chosen by the user. Note that you will need to send the event even if the user selects an express method. MoneyHash will return updated intent details with a new state depending on the selected method.

3. **Handling Express Methods:**
   - If there are express methods, they are either Google Pay or Apple Pay.
   - **Google Pay**: After sending the selected method, you can render the MoneyHash embed to handle the flow using the [Render MoneyHash Embed Form](./APIsDocs.md#1-render-moneyhash-embed-form) API. Note that you can disable Google Pay from your dashboard.
   - **Apple Pay**: You will receive intent details with `intentForm` as the state but with `nativePayData` in the intent details containing `ApplePayData`. You can then use the [Check Device Compatibility for Apple Pay](./APIsDocs.md#11-isdevicecompatible-method) API to check if the device can use Apple Pay. If the device is compatible, you can use the [Show Apple Pay Payment Sheet](./APIsDocs.md#12-showpaymentsheet-method) API to present the Apple Pay payment sheet.

This process ensures that you handle all types of payment methods and provide a seamless user experience.

---

Certainly! Below is the updated documentation with the mention of `CardInputFieldState` and its explanation included in the "Handling Card Tokenization" section under "Create a Card Form Collector":

---

### Handling the `formFields` State

When handling the `formFields` state in MoneyHash, you will deal with two primary scenarios: managing billing or shipping data and handling card tokenization. These scenarios are broken down into steps for clarity.

---

#### Handling Billing or Shipping Data

This section covers how to manage the billing and shipping data that may be part of the `formFields` state.

1. **Rendering Input Fields**:
   - Each [`InputField`](./ModelsDocs.md#19-inputfield) in the array corresponds to a specific field that the user needs to fill out.
   - The [`InputField`](./ModelsDocs.md#19-inputfield) model provides detailed information about the field, including its type ([`InputFieldType`](./ModelsDocs.md#21-inputfieldtype)), label, placeholder, and constraints (like `maxLength` and `minLength`).
   - You can render these fields using native UI components based on the details provided by the [`InputField`](./ModelsDocs.md#19-inputfield) model.

2. **Collecting User Input**:
   - After the user has entered the data, you should collect the data in the form of a map where the keys are the field names and the values are the user inputs.

   Example of a collected data map:
   ```swift
   let collectedData: [String: String] = [
       "firstName": "John",
       "lastName": "Doe",
       "email": "john.doe@example.com",
       "address": "123 Main St",
       "city": "New York"
   ]
   ```

---

#### Handling Card Tokenization

This section outlines the steps required to handle card tokenization securely using MoneyHash's tools.

1. **Create a Card Form Collector**:
   - Begin by creating a `CardFormCollector` using the `CardFormBuilder`. This collector manages the card form data securely.
   - As you build the form collector, you will use a structure called [`CardInputFieldState`](./ModelsDocs.md#33-cardinputfieldstate) to manage the state of each card input field. This state includes information about the validity of the input, any associated error messages, and whether the field is currently focused. This information is crucial for providing real-time feedback to users and ensuring that their inputs are correctly formatted before submission.

   Example of creating a `CardFormCollector`:
   ```swift
   let cardFormCollector = try CardFormBuilder()
       .setCardNumberField { state in
           // Handle card number field state changes here
           // The `state` parameter is of type `CardInputFieldState`
       }
       .setCVVField { state in
           // Handle CVV field state changes here
           // The `state` parameter is of type `CardInputFieldState`
       }
       .setCardHolderNameField { state in
           // Handle cardholder name field state changes here
           // The `state` parameter is of type `CardInputFieldState`
       }
       .setExpireMonthField { state in
           // Handle expiration month field state changes here
           // The `state` parameter is of type `CardInputFieldState`
       }
       .setExpireYearField { state in
           // Handle expiration year field state changes here
           // The `state` parameter is of type `CardInputFieldState`
       }
       .set(tokenizeCardInfo: yourTokenizeCardInfo)
       .build()
   ```

2. **Create Secure Text Fields and Pass the Collector to Them**:
   - After creating the `CardFormCollector`, initialize secure text fields for each card field type. Each secure text field is linked to the `CardFormCollector` to manage input securely.

   Example of creating secure text fields:
   ```swift
   let cardNumberField = SecureTextField(cardFormCollector: cardFormCollector, type: .cardNumber) {
       Text("Card Number")
   }

   let cvvField = SecureTextField(cardFormCollector: cardFormCollector, type: .cvv) {
       Text("CVV")
   }

   let cardHolderNameField = SecureTextField(cardFormCollector: cardFormCollector, type: .cardHolderName) {
       Text("Cardholder Name")
   }

   let expireMonthField = SecureTextField(cardFormCollector: cardFormCollector, type: .expireMonth) {
       Text("Expiration Month")
   }

   let expireYearField = SecureTextField(cardFormCollector: cardFormCollector, type: .expireYear) {
       Text("Expiration Year")
   }
   ```

   **Note**: You need to initialize five secure text fields—one for each type of card field—passing the same `CardFormCollector` instance to all of them.

3. **Validation**:
   - The `CardFormCollector` provides the ability to validate the entered card data before submission.

   Example of validating the card data:
   ```swift
   if cardFormCollector.isValid {
       print("Card data is valid.")
   } else {
       print("Card data is invalid.")
   }
   ```

4. **Collection**:
   - After validating the card data, you can send the card information to MoneyHash's vault using the `collect` method.

   Example of collecting and submitting card data:
   ```swift
   do {
       let vaultData = try await cardFormCollector.collect(intentID: "your_intent_id")
       print("Card data successfully collected and sent to MoneyHash vault: \(vaultData)")
   } catch {
       print("Failed to collect card data: \(error)")
   }
   ```

This approach ensures that you securely handle and submit card information, complying with best practices for sensitive data.

---

### Overview of MoneyHash APIs

The MoneyHash SDK provides a robust set of APIs to manage payment intents, methods, and transactions. Below are the key API methods available:

- **[Render MoneyHash Embed Form](./APIsDocs.md#1-render-moneyhash-embed-form)**: Display the MoneyHash payment form in your application.
- **[Retrieve Available Methods](./APIsDocs.md#2-retrieve-available-methods)**: Fetch the available payment methods for a specific intent.
- **[Retrieve Intent Details](./APIsDocs.md#3-retrieve-intent-details)**: Retrieve detailed information about a specific intent.
- **[Delete a Saved Card](./APIsDocs.md#4-delete-a-saved-card)**: Remove a saved card from the user's account.
- **[Reset Selected Method](./APIsDocs.md#5-reset-selected-method)**: Reset the selected payment or payout method for a specified intent.
- **[Proceed with Selected Method](./APIsDocs.md#6-proceed-with-selected-method)**: Proceed with a specified payment or payout method for a given intent.
- **[Submit Form](APIsDocs.md#7-submit-form)**: Submit a form with billing, shipping, and other required data.
- **[Submit Card CVV](APIsDocs.md#8-submit-card-cvv)**: Submit the CVV for a card associated with a specified intent.
- **[Set Logging Level](APIsDocs.md#9-set-logging-level)**: Configure the logging level for the SDK.
- **[Submit Payment Receipt](APIsDocs.md#10-submit-payment-receipt)**: Submit a payment receipt for a specified intent.
- **[Check Device Compatibility for Apple Pay](APIsDocs.md#11-isdevicecompatible-method)**: Determine if the device is compatible with Apple Pay.
- **[Show Apple Pay Payment Sheet](APIsDocs.md#12-showpaymentsheet-method)**: Display the Apple Pay payment sheet for the user.

For a comprehensive guide to all available APIs, including their parameters, return types, and usage examples, please see the [APIsDocs.md](APIsDocs.md) file.

---

### Overview of MoneyHash Models

The MoneyHash SDK models represent the various entities involved in payment processing, such as intents, methods, transactions, and more. Key models include:

- **[MHError](./ModelsDocs.md#1-mherror)**: Represents different types of errors that can occur within the MoneyHash SDK.
- **[FieldError](./ModelsDocs.md#2-fielderror)**: Represents an error related to a specific field.
- **[MethodsResult](./ModelsDocs.md#3-methodsresult)**: Represents the result of available methods for an intent.
- **[IntentMethods](./ModelsDocs.md#4-intentmethods)**: Represents different payment methods available for an intent.
- **[IntentDetails](./ModelsDocs.md#5-intentdetails)**: Provides detailed information about an intent.
- **[Intent](./ModelsDocs.md#6-intent)**: Represents the core details of an intent.
- **[AmountData](./ModelsDocs.md#7-amountdata)**: Represents the monetary value related to an intent.
- **[IntentStatus](./ModelsDocs.md#8-intentstatus)**: Enum representing the possible statuses of an intent.
- **[IntentType](./ModelsDocs.md#9-intenttype)**: Enum representing the type of an intent.
- **[Transaction](./ModelsDocs.md#10-transaction)**: Represents details about a transaction within an intent.
- **[SavedCard](./ModelsDocs.md#11-savedcard)**: Represents a saved card used in transactions.
- **[PayoutMethod](./ModelsDocs.md#12-payoutmethod)**: Represents a payout method available for the user.
- **[PaymentMethod](./ModelsDocs.md#13-paymentmethod)**: Represents a payment method available for the user.
- **[IntentMethodType](./ModelsDocs.md#14-intentmethodtype)**: Enum representing different types of methods available for an intent.
- **[IntentMethodMetaData](./ModelsDocs.md#15-intentmethodmetadata)**: Contains metadata related to a payment method, such as CVV.
- **[ExpressMethod](./ModelsDocs.md#16-expressmethod)**: Represents an express payment method.
- **[CustomerBalance](./ModelsDocs.md#17-customerbalance)**: Represents a customer balance available for use in an intent.
- **[ApplePayData](./ModelsDocs.md#18-applepaydata)**: Contains data necessary for configuring an Apple Pay transaction.
- **[InputField](./ModelsDocs.md#19-inputfield)**: Represents a field in a form used for collecting user input.
- **[OptionItem](./ModelsDocs.md#20-optionitem)**: Represents an option item in a selectable list within an input field.
- **[InputFieldType](./ModelsDocs.md#21-inputfieldtype)**: Enum representing the type of an input field.
- **[ErrorMessagesData](./ModelsDocs.md#22-errormessagesdata)**: Represents custom error messages for validation in forms.
- **[CardEmbed](./ModelsDocs.md#23-cardembed)**: Represents the data needed to embed a card in the payment process.
- **[SaveCardCheckbox](./ModelsDocs.md#24-savecardcheckbox)**: Represents the configuration for the save card checkbox.
- **[FeeItem](./ModelsDocs.md#25-feeitem)**: Represents a fee item associated with an intent.
- **[Language](./ModelsDocs.md#26-language)**: Enum representing different languages.
- **[LogLevel](./ModelsDocs.md#27-loglevel)**: Enum representing different levels of logging.
- **[NativePayData](./ModelsDocs.md#28-nativepaydata)**: Enum representing data for native payment methods like Apple Pay.
- **[ProductItem](./ModelsDocs.md#29-productitem)**: Represents an item associated with a product in an intent.

- **[IntentStateDetails](./ModelsDocs.md#30-intentstatedetails)**: Enum representing different states an intent can be in.
- **[CardTokenData](./ModelsDocs.md#31-cardtokendata)**: Represents token data for a card used in payment processing.
- **[CardFieldType](./ModelsDocs.md#32-cardfieldtype)**: representing the different types of card fields.

For detailed descriptions of all models, including their properties and how they are used in the SDK, please refer to the [ModelsDocs.md](./ModelsDocs.md) file.

---
### Migration Guide from v1 to v2

We have recently released version 2 of the MoneyHash SDK, which includes significant improvements and new features. If you are upgrading from version 1, please refer to our [Migration Guide to V2](./MIGRATION_TO_V2.md) for detailed instructions on how to transition your existing integration to version 2. This guide will help you understand the changes and provide step-by-step instructions for a smooth upgrade.


---
This documentation serves as your entry point to understanding the MoneyHash SDK. For more detailed information on the APIs and models, please refer to the linked documentation files.
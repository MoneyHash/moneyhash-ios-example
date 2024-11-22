---

# How to use MoneyHash V2 iOS

Welcome to the MoneyHash SDK documentation! This document provides an overview of the core functionalities available in the MoneyHash SDK, focusing on intent states, API methods, and models.

---

### Intent States Documentation

In the MoneyHash SDK, intents can exist in various states, each requiring specific actions to be completed. Below is a summary of the different intent states and the actions associated with them.

#### Intent States and Corresponding Actions

| State                             | Action                                                                                                                                                                                                                                                             |
| :-------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `methodSelection(methods: IntentMethods?)`                | [Handle this state](#how-to-handle-method-selection) by rendering the payment methods provided in `methods` directly in your UI for user selection. After the user selects a method, proceed with the method by calling [`moneyHashSDK.proceedWithMethod`](./APIsDocs.md#6-proceedwithmethod).                                                                                                  |
| `formFields(tokenizeCardInfo: TokenizeCardInfo?, billingFields: [InputField]?, shippingFields: [InputField]?)`  | [Handle this state](#handling-the-formfields-state) by rendering the form fields provided in the `billingFields`, `shippingFields`, and `tokenizeCardInfo`. These fields should be displayed natively in your UI. Once the user completes the form, submit the data using [`moneyHashSDK.submitForm`](./APIsDocs.md#7-submitform).                        |
| `redirectToURL(url: String?, renderStrategy: RenderStrategy?)`  | Render the MoneyHash embed form using the [`moneyHashSDK.renderForm`](./APIsDocs.md#1-renderform) method. This will let MoneyHash handle the payments for you. Use the `completionHandler` to track the result of the form submission, including success or failure.                                                                                             |
| `savedCardCVV(cvvField: InputField, cardTokenData: CardTokenData?)` | Render a CVV input field using the schema received in `cvvField`. You can also display basic card information from [`cardTokenData`](./ModelsDocs.md#36-cardtokendata). Once the CVV is entered by the user, submit it using [`moneyHashSDK.submitCardCVV`](./APIsDocs.md#8-submitcardcvv).                                          |
| `intentForm`                     | Render the MoneyHash embed form using the [`moneyHashSDK.renderForm`](./APIsDocs.md#1-renderform) method. This will let MoneyHash handle the payments for you. Use the `completionHandler` to track the result of the form submission, including success or failure.                               |
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
   Use the [Proceed with Selected Method](./APIsDocs.md#6-proceedwithmethod) API to proceed with the method chosen by the user. Note that you will need to send the event even if the user selects an express method. MoneyHash will return updated intent details with a new state depending on the selected method.

3. **Handling Express Methods:**
   - If there are express methods, they are either Google Pay or Apple Pay.
   - **Google Pay**: After sending the selected method, you can render the MoneyHash embed to handle the flow using the [Render MoneyHash Embed Form](./APIsDocs.md#1-renderform) API. Note that you can disable Google Pay from your dashboard.
   - **Apple Pay**: You will receive intent details with `intentForm` as the state but with [`nativePayData`](./ModelsDocs.md#31-applepaydata) in the intent details containing [`ApplePayData`](./ModelsDocs.md#31-applepaydata). you can use the [proceed with Apple Pay](./APIsDocs.md#11-proceedwithapplepay) API to present the Apple Pay payment sheet.

This process ensures that you handle all types of payment methods and provide a seamless user experience.

---

### Handling the `formFields` State

When handling the `formFields` state in MoneyHash, you will deal with two primary scenarios: managing billing or shipping data and handling card tokenization. These scenarios are broken down into steps for clarity.

---

#### Handling Billing or Shipping Data

This section covers how to manage the billing and shipping data that may be part of the `formFields` state.

1. **Rendering Input Fields**:
   - Each [`InputField`](./ModelsDocs.md#32-inputfield) in the array corresponds to a specific field that the user needs to fill out.
   - The [`InputField`](./ModelsDocs.md#32-inputfield) model provides detailed information about the field, including its type ([`InputFieldType`](./ModelsDocs.md#34-inputfieldtype)), label, placeholder, and constraints (like `maxLength` and `minLength`).
   - You can render these fields using native UI components based on the details provided by the [`InputField`](./ModelsDocs.md#32-inputfield) model.

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
   - As you build the form collector, you will use a structure called [`CardInputFieldState`](./ModelsDocs.md#38-cardinputfieldstate) to manage the state of each card input field. This state includes information about the validity of the input, any associated error messages, and whether the field is currently focused. This information is crucial for providing real-time feedback to users and ensuring that their inputs are correctly formatted before submission.

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

   **Note**: You need to initialize five secure

 text fields—one for each type of card field—passing the same `CardFormCollector` instance to all of them.

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
Here's the updated documentation with new sections for updating fees and discounts, including the requested code examples with more professional string replacements:

---

### How to Update Fees

Updating fees for a payment intent is a straightforward process using the `updateFees` API. This is useful when you need to apply new fees or modify existing ones during the payment process.

1. **Create the `FeeItem` Objects:**
   - You need to define each fee, including the title (localized for different languages), value, and any applicable discounts.

2. **Call the `updateFees` API:**
   - Pass the intent ID and the list of `FeeItem` objects to update the fees for the payment intent.

**Example:**

```swift
do {
    let response = try await moneyHashSDK.updateFees(
        intentId: intentID,
        fees: [
            FeeItem(
                title: [.arabic: "رسوم خدمة", .english: "Service Fee"],
                value: "15",
                discount: DiscountItem(
                    title: [.arabic: "خصم خاص", .english: "Special Discount"],
                    type: .percentage,
                    value: "10"
                )
            ),
            FeeItem(
                title: [.english: "Additional Fee"],
                value: "20",
                discount: nil
            )
        ]
    )
    DispatchQueue.main.async {
        self.updatedFeesResponse = response
        self.isLoading = false
    }
} catch {
    DispatchQueue.main.async {
        self.isLoading = false
        self.errorMessage = "Failed to update fees: \((error as! MHError).errors.first?.message ?? "Unknown error")"
    }
}
```

---

### How to Update Discounts

The `updateDiscount` API allows you to apply or modify a discount for a payment intent. This is typically used when offering promotions or special deals to users.

1. **Create the `DiscountItem` Object:**
   - Define the discount, including a localized title, the discount type (amount or percentage), and the discount value.

2. **Call the `updateDiscount` API:**
   - Pass the intent ID and the `DiscountItem` object to apply the discount.

**Example:**

```swift
do {
    let response = try await moneyHashSDK.updateDiscount(
        intentId: intentID,
        discount: DiscountItem(
            title: [.arabic: "خصم موسمي", .english: "Seasonal Discount"],
            type: .percentage,
            value: "15"
        )
    )
    DispatchQueue.main.async {
        self.updatedDiscountResponse = response
        self.isLoading = false
    }
} catch {
    DispatchQueue.main.async {
        self.isLoading = false
        self.errorMessage = "Failed to update discount: \(error.localizedDescription)"
    }
}
```

---

### Overview of MoneyHash APIs

The MoneyHash SDK provides a robust set of APIs to manage payment intents, methods, and transactions.

For a comprehensive guide to all available APIs, including their parameters, return types, and usage examples, please see the [APIsDocs.md](APIsDocs.md) file.

---

### Overview of MoneyHash Models

The MoneyHash SDK models represent the various entities involved in payment processing, such as intents, methods, transactions, and more. 

For detailed descriptions of all models, including their properties and how they are used in the SDK, please refer to the [ModelsDocs.md](./ModelsDocs.md) file.

---

### Migration Guide from v1 to v2

We have recently released version 2 of the MoneyHash SDK, which includes significant improvements and new features. If you are upgrading from version 1, please refer to our [Migration Guide to V2](./MIGRATION_TO_V2.md) for detailed instructions on how to transition your existing integration to version 2. This guide will help you understand the changes and provide step-by-step instructions for a smooth upgrade.

---

This documentation serves as your entry point to understanding the MoneyHash SDK. For more detailed information on the APIs and models, please refer to the linked documentation files.

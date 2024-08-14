### MoneyHash SDK API Documentation

The MoneyHash SDK provides a comprehensive set of APIs to interact with various payment-related operations such as managing payment intents, handling payment methods, and processing transactions. This documentation covers the API methods available through the `MoneyHashSDK` protocol and includes detailed explanations of each method, its parameters, possible enum cases, and examples of usage.

---

### API Documentation for MoneyHashSDK Protocol

The `MoneyHashSDK` protocol defines several methods for managing payment intents, handling payment methods, and processing transactions.

#### 1. Render MoneyHash Embed Form

```swift
func renderForm(
    on viewController: UIViewController,
    intentId: String,
    embedStyle: EmbedStyle?,
    intentType: IntentType,
    completionHandler: @escaping (Result<IntentDetails, Error>) -> Void
)
```

- **Purpose**: Renders the MoneyHash embed form on a specified `UIViewController`.
- **Parameters**:
  - `viewController`: The `UIViewController` on which the form will be rendered.
  - `intentId`: The unique identifier of the intent.
  - `embedStyle`: Optional styling to be applied to the embed form.
  - `intentType`: The type of the intent, either `payment` or `payout`.
    - **Enum Cases**:
      - `.payment`: Represents a payment intent.
      - `.payout`: Represents a payout intent.
  - `completionHandler`: A closure called upon form submission, returning `IntentDetails` or an `Error`.
- **Example**:

```swift
self.moneyHashSDK.renderForm(
    on: self,
    intentId: "Z1ED7zZ",
    embedStyle: nil, // Optional embed style
    intentType: .payment
) { result in
    switch result {
    case .success(let intentDetails):
        print("Form submission successful: \(intentDetails)")
        // Handle the intent details after submission
    case .failure(let error):
        print("Error in form submission: \(error)")
    }
}
```

---

#### 2. Retrieve Available Methods

```swift
func getIntentMethods(
    intentId: String,
    intentType: IntentType
) async throws -> IntentMethods
```

- **Purpose**: Retrieves the available payment methods for a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent, either `payment` or `payout`.
    - **Enum Cases**:
      - `.payment`: Represents a payment intent.
      - `.payout`: Represents a payout intent.
- **Returns**: `IntentMethods` containing the available methods.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let methods = try await self.moneyHashSDK.getIntentMethods(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print("Available methods: \(methods)")
    // Render the methods in the UI
} catch {
    print("Error retrieving methods: \(error)")
}
```

---

#### 3. Retrieve Intent Details

```swift
func getIntentDetails(
    intentId: String,
    intentType: IntentType
) async throws -> IntentDetails
```

- **Purpose**: Retrieves the details of a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent, either `payment` or `payout`.
    - **Enum Cases**:
      - `.payment`: Represents a payment intent.
      - `.payout`: Represents a payout intent.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let intentDetails = try await self.moneyHashSDK.getIntentDetails(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print("Intent details: \(intentDetails)")
    // Handle the retrieved intent details
} catch {
    print("Error retrieving intent details: \(error)")
}
```

---

#### 4. Delete a Saved Card

```swift
func deleteSavedCard(
    cardTokenId: String,
    intentSecret: String
) async throws -> Bool
```

- **Purpose**: Deletes a saved card using its token ID.
- **Parameters**:
  - `cardTokenId`: The token ID of the card to be deleted.
  - `intentSecret`: The secret associated with the intent.
- **Returns**: A Boolean value indicating whether the card was successfully deleted.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let success = try await self.moneyHashSDK.deleteSavedCard(
        cardTokenId: "card_token_123",
        intentSecret: "secret_456"
    )
    print("Card deleted successfully: \(success)")
} catch {
    print("Error deleting card: \(error)")
}
```

---

#### 5. Reset Selected Method

```swift
func resetSelectedMethod(
    intentId: String,
    intentType: IntentType
) async throws -> MethodsResult
```

- **Purpose**: Resets the selected payment or payout method for a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent, either `payment` or `payout`.
    - **Enum Cases**:
      - `.payment`: Represents a payment intent.
      - `.payout`: Represents a payout intent.
- **Returns**: The details of the intent and the available methods encapsulated in `MethodsResult`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let methodsResult = try await self.moneyHashSDK.resetSelectedMethod(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print("Methods reset successfully: \(methodsResult)")
} catch {
    print("Error resetting methods: \(error)")
}
```

---

#### 6. Proceed with Selected Method

```swift
func proceedWithMethod(
    intentId: String,
    intentType: IntentType,
    selectedMethodId: String,
    methodType: IntentMethodType,
    metaData: IntentMethodMetaData?
) async throws -> MethodsResult
```

- **Purpose**: Proceeds with the specified payment or payout method for a given intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent, either `payment` or `payout`.
    - **Enum Cases**:
      - `.payment`: Represents a payment intent.
      - `.payout`: Represents a payout intent.
  - `selectedMethodId`: The name of the selected payment method.
  - `methodType`: The type of the payment method.
    - **Enum Cases**:
      - `.paymentMethod`: Represents a standard payment method.
      - `.expressMethod`: Represents an express payment method.
      - `.payoutMethod`: Represents a payout method.
      - `.savedCard`: Represents a saved card method.
      - `.customerBalance`: Represents a customer balance method.
  - `metaData`: Optional metadata for the method.
- **Returns**: The details of the intent and the available methods encapsulated in `MethodsResult`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let methodsResult = try await self.moneyHashSDK.proceedWithMethod(
        intentId: "Z1ED7zZ",
        intentType: .payment,
        selectedMethodId: "method_123",
        methodType: .paymentMethod,
        metaData: nil // Optional metadata
    )
    print("Proceeded with method: \(methodsResult)")
} catch {
    print("Error proceeding with method: \(error)")
}
```

---

#### 7. Submit Form

```swift
func submitForm(
    intentID: String,
    selectedMethod: String,
    billingData: [String: String]?,
    shippingData: [String: String]?,
    vaultData: VaultData?
) async throws -> IntentDetails
```

- **Purpose**: Submits the form with the provided data.
- **Parameters**:
  - `intentID`: The unique identifier of the intent.
  - `selectedMethod`: The name of the selected payment method.
  - `billingData`: Optional billing details as a key-value map.
  - `shippingData`: Optional shipping details as a key-value map.
  - `vaultData`: Optional data from vault tokenization.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let intentDetails = try await self.moneyHashSDK.submitForm(
        intentID: "Z1ED7zZ",
        selectedMethod: "selectedMethod",
        billingData: ["address": "123 Main St", "city": "New York"],
        shippingData: ["address": "456 Elm St", "city": "Boston"],
        vaultData: nil // Optional VaultData for card information
    )
    print("Form submitted successfully: \(intentDetails)")
    // handle the updated intent details
} catch {
    print("Error: \(error)")
}
```

---

#### 8. Submit Card CVV

```swift
func submitCardCVV(
    intentID: String,
    cvv: String
) async throws -> IntentDetails
```

-

 **Purpose**: Submits the CVV for a card associated with a specified intent.
- **Parameters**:
  - `intentID`: The unique identifier of the intent.
  - `cvv`: The CVV of the card.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let intentDetails = try await self.moneyHashSDK.submitCardCVV(
        intentID: "Z1ED7zZ",
        cvv: "123"
    )
    print("CVV submitted successfully: \(intentDetails)")
    // handle the updated intent details
} catch {
    print("Error: \(error)")
}
```

---

#### 9. Set Logging Level

```swift
func setLogLevel(logLevel: LogLevel)
```

- **Purpose**: Sets the logging level for the SDK.
- **Parameters**:
  - `logLevel`: The desired logging level.
    - **Enum Cases**:
      - `.verbose`: Logs detailed debug information.
      - `.debug`: Logs general debug information.
      - `.info`: Logs general informational messages.
      - `.warning`: Logs warning messages.
      - `.error`: Logs error messages.
      - `.assert`: Logs assertion failures.
- **Example**:

```swift
self.moneyHashSDK.setLogLevel(logLevel: .debug)
print("Log level set to debug")
```

---

#### 10. Submit Payment Receipt

```swift
func submitPaymentReceipt(
    intentId: String,
    data: String
) async throws -> IntentDetails
```

- **Purpose**: Submits a payment receipt for the specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the payment intent.
  - `data`: The receipt data to be submitted.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.
- **Throws**: `MHError` if the operation fails.
- **Example**:

```swift
do {
    let intentDetails = try await self.moneyHashSDK.submitPaymentReceipt(
        intentId: "Z1ED7zZ",
        data: "receipt_data_string"
    )
    print("Receipt submitted successfully: \(intentDetails)")
    // handle the updated intent details
} catch {
    print("Error: \(error)")
}
```


---

#### 11. Proceed with Apple Pay

```swift
func proceedWithApplePay(
    depositAmount: Float,
    merchantIdentifier: String,
    currencyCode: String,
    countryCode: String,
    completionHandler: @escaping (Result<String, ApplePayStatus>) -> Void
)
```

- **Purpose**: Facilitates the presentation of an Apple Pay payment sheet, checking device compatibility, configuring the payment request, and presenting the authorization view controller.
- **Parameters**:
  - `depositAmount`: The amount to be paid, specified as a `Float`.
  - `merchantIdentifier`: A string that uniquely identifies the merchant.
  - `currencyCode`: The currency code in which the payment will be made (e.g., "USD", "EUR").
  - `countryCode`: The country code associated with the payment (e.g., "US", "GB").
  - `completionHandler`: A closure that is called when the payment process is completed. The closure takes a `Result<String, ApplePayStatus>` as a parameter, where `String` represents a success message and `ApplePayStatus` represents a failure status.
- **Returns**: This method does not return a value directly. Instead, the result is handled within the `completionHandler`.
- **Throws**: This method does not throw errors directly, but errors are handled within the `completionHandler` as `ApplePayStatus`.
- **Example**:

```swift
self.moneyHashSDK.proceedWithApplePay(
    depositAmount: 99.99,
    merchantIdentifier: "merchant.com.example",
    currencyCode: "USD",
    countryCode: "US"
) { result in
    switch result {
    case .success(let message):
        print("Payment successful: \(message)")
    case .failure(let status):
        print("Apple Pay failed with status: \(status)")
    }
}
```

---

This API documentation provides detailed descriptions and examples for each method in the `MoneyHashSDK` and Apple Pay services, making it easier for developers to integrate these functionalities into their iOS applications.
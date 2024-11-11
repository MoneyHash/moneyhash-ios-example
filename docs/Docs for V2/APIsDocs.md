### MoneyHash SDK API Documentation

The MoneyHash SDK provides a comprehensive set of APIs to interact with various payment-related operations such as managing payment intents, handling payment methods, and processing transactions. This documentation covers the API methods available through the `MoneyHashSDK` protocol and includes detailed explanations of each method, its parameters, possible enum cases, and examples of usage.

---

### 1. `renderForm`

```swift
func renderForm(
    on viewController: UIViewController,
    intentId: String,
    embedStyle: EmbedStyle?,
    intentType: IntentType,
    completionHandler: @escaping (Result<IntentDetails, Error>) -> Void
)
```

- **Description**: Renders the MoneyHash embed form.
- **Parameters**:
  - `viewController`: The `UIViewController` on which the form will be rendered.
  - `intentId`: The unique identifier of the intent.
  - `embedStyle`: Optional styling to be applied to the embedded form.
  - `intentType`: The type of the intent (`payment`, `payout`).
  - `completionHandler`: A closure that is called when the form submission is completed, returning a result containing `IntentDetails` or an `Error`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

moneyHashSDK.renderForm(
    on: self,
    intentId: "intent_id_12345",
    embedStyle: nil,
    intentType: .payment
) { result in
    switch result {
    case .success(let intentDetails):
        print("Form submitted successfully: \(intentDetails)")
    case .failure(let error):
        print("Error submitting form: \(error)")
    }
}
```

---

### 2. `getIntentMethods`

```swift
func getIntentMethods(
    intentId: String,
    intentType: IntentType
) async throws -> IntentMethods
```

- **Description**: Retrieves the available methods for a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent (`payment`, `payout`).
- **Throws**: An `MHError` if the operation fails.
- **Returns**: `IntentMethods` containing the available methods.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let methods = try await moneyHashSDK.getIntentMethods(intentId: "intent_id_12345", intentType: .payment)
        print("Available methods: \(methods)")
    } catch {
        print("Error retrieving methods: \(error)")
    }
}
```

---

### 3. `getIntentDetails`

```swift
func getIntentDetails(
    intentId: String,
    intentType: IntentType
) async throws -> IntentDetails
```

- **Description**: Retrieves the details of a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent (`payment`, `payout`).
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let details = try await moneyHashSDK.getIntentDetails(intentId: "intent_id_12345", intentType: .payment)
        print("Intent details: \(details)")
    } catch {
        print("Error retrieving intent details: \(error)")
    }
}
```

---

### 4. `deleteSavedCard`

```swift
func deleteSavedCard(
    cardTokenId: String,
    intentSecret: String
) async throws -> Bool
```

- **Description**: Deletes a saved card using its token ID.
- **Parameters**:
  - `cardTokenId`: The token ID of the card to be deleted.
  - `intentSecret`: The secret associated with the intent.
- **Throws**: An `MHError` if the operation fails.
- **Returns**: A Boolean value indicating whether the card was successfully deleted.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let success = try await moneyHashSDK.deleteSavedCard(cardTokenId: "token_id_12345", intentSecret: "intent_secret_123")
        print("Card deleted successfully: \(success)")
    } catch {
        print("Error deleting card: \(error)")
    }
}
```

---

### 5. `resetSelectedMethod`

```swift
func resetSelectedMethod(
    intentId: String,
    intentType: IntentType
) async throws -> MethodsResult
```

- **Description**: Resets the selected (payment/payout) method for a specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent (`payment`, `payout`).
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent and the available methods encapsulated in `MethodsResult`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let result = try await moneyHashSDK.resetSelectedMethod(intentId: "intent_id_12345", intentType: .payment)
        print("Method reset successfully: \(result)")
    } catch {
        print("Error resetting method: \(error)")
    }
}
```

---

### 6. `proceedWithMethod`

```swift
func proceedWithMethod(
    intentId: String,
    intentType: IntentType,
    selectedMethodId: String,
    methodType: IntentMethodType,
    metaData: IntentMethodMetaData?
) async throws -> MethodsResult
```

- **Description**: Proceeds with the specified (payment/payout) method for a given intent.
- **Parameters**:
  - `intentId`: The unique identifier of the intent.
  - `intentType`: The type of the intent (`payment`, `payout`).
  - `selectedMethodId`: The name of the selected payment method.
  - `methodType`: The type of the payment method.
  - `metaData`: Optional metadata for the method.
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent and the available methods encapsulated in `MethodsResult`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let result = try await moneyHashSDK.proceedWithMethod(
            intentId: "intent_id_12345",
            intentType: .payment,
            selectedMethodId: "selected_method_123",
            methodType: .paymentMethod,
            metaData: nil
        )
        print("Proceeded with method successfully: \(result)")
    } catch {
        print("Error proceeding with method: \(error)")
    }
}
```

---

### 7. `submitForm`

```swift
func submitForm(
    intentID: String,
    selectedMethod: String,
    billingData: [String: String]?,
    shippingData: [String: String]?,
    vaultData: VaultData?
) async throws -> IntentDetails
```

- **Description**: Submits the form with the provided data.
- **Parameters**:
  - `intentID`: The unique identifier of the intent.
  - `selectedMethod`: The name of the selected payment method.
  - `billingData`: Optional billing details as a key-value map.
  - `shippingData`: Optional shipping details as a key-value map.
  - `vaultData`: Optional data from vault tokenization.
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let intentDetails = try await moneyHashSDK.submitForm(
            intentID: "intent_id_12345",
            selectedMethod: "selected_method_123",
            billingData: ["address": "123 Street Name"],
            shippingData: nil,
            vaultData: nil
        )
        print("Form submitted successfully: \(intentDetails)")
    } catch {
        print("Error submitting form: \(error)")
    }
}
```

---

### 8. `submitCardCVV`

```swift
func submitCardCVV(
    intentID: String,
    cvv: String
) async throws -> IntentDetails
```

- **Description**: Submits the CVV for a card associated with a specified intent.
- **Parameters**:
  - `intentID`: The unique identifier of the intent.
  - `cvv`: The CVV of the card.
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let intentDetails = try await moneyHashSDK.submitCardCVV(
            intentID: "intent_id_12345",
            cvv: "123"
        )
        print("CVV submitted successfully: \(intentDetails)")
    } catch {
        print("Error submitting CVV: \(error)")
    }
}
```

---

### 9. `setLogLevel`

```swift
func setLogLevel(logLevel: LogLevel)
``

`

- **Description**: Sets the logging level for the SDK.
- **Parameters**:
  - `logLevel`: The desired logging level.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
moneyHashSDK.setLogLevel(logLevel: .debug)
```

---

### 10. `submitPaymentReceipt`

```swift
func submitPaymentReceipt(
    intentId: String,
    data: String
) async throws -> IntentDetails
```

- **Description**: Submits a payment receipt for the specified intent.
- **Parameters**:
  - `intentId`: The unique identifier of the payment intent.
  - `data`: The receipt data to be submitted.
- **Throws**: An `MHError` if the operation fails.
- **Returns**: The details of the intent encapsulated in `IntentDetails`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let intentDetails = try await moneyHashSDK.submitPaymentReceipt(intentId: "intent_id_12345", data: "receipt_data")
        print("Receipt submitted successfully: \(intentDetails)")
    } catch {
        print("Error submitting receipt: \(error)")
    }
}
```

---

### 11. `proceedWithApplePay`

```swift
func proceedWithApplePay(
    intentID: String,
    depositAmount: Float,
    merchantIdentifier: String,
    currencyCode: String,
    countryCode: String
) async throws -> IntentDetails
```

- **Description**: Handles the presentation of an Apple Pay payment sheet and processes the resulting payment data asynchronously.
- **Parameters**:
  - `intentID`: A unique identifier for the payment intent.
  - `depositAmount`: The amount to be paid, specified as a `Float`.
  - `merchantIdentifier`: A string that uniquely identifies the merchant for Apple Pay.
  - `currencyCode`: The currency code in which the payment will be made (e.g., "USD", "EUR").
  - `countryCode`: The country code associated with the payment (e.g., "US", "GB").
- **Throws**: An error if the payment fails or if there is an issue while submitting the payment receipt.
- **Returns**: An `IntentDetails` object containing updated information after the payment is processed.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()

Task {
    do {
        let intentDetails = try await moneyHashSDK.proceedWithApplePay(
            intentID: "intent_id_12345",
            depositAmount: 99.99,
            merchantIdentifier: "merchant.com.example",
            currencyCode: "USD",
            countryCode: "US"
        )
        print("Apple Pay processed successfully: \(intentDetails)")
    } catch {
        print("Error processing Apple Pay: \(error)")
    }
}
```

---

### 12. `isDeviceCompatible`

```swift
func isDeviceCompatible() -> Bool
```

- **Description**: Checks if the device is compatible with Apple Pay.
- **Returns**: `true` if the device can make payments using Apple Pay, `false` otherwise.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let isCompatible = moneyHashSDK.isDeviceCompatible()

if isCompatible {
    print("Device is compatible with Apple Pay.")
} else {
    print("Device is not compatible with Apple Pay.")
}
```

---

### 13. `validateField`

```swift
func validateField(
    fieldType: CardFieldType,
    currentValue: String
) -> CardFieldState
```

- **Description**: Validates a single field based on the given type and current value.
- **Parameters**:
  - `fieldType`: The type of the card field to validate.
  - `currentValue`: The current string value of the field to be validated.
- **Returns**: A `CardFieldState` representing the validation state of the field.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let fieldState = moneyHashSDK.validateField(fieldType: .cardNumber, currentValue: "4111111111111111")

if fieldState.isValid ?? false {
    print("Card number is valid.")
} else {
    print("Card number is invalid: \(fieldState.errorMessage ?? "Unknown error")")
}
```

---

### 14. `isValidForm`

```swift
func isValidForm(
    fields: [CardFieldType: String]
) -> CardFormState
```

- **Description**: Validates all provided fields and returns the overall state of the form.
- **Parameters**:
  - `fields`: A dictionary mapping `CardFieldType` to their respective string values.
- **Returns**: A `CardFormState` containing the overall validity of the form and the states of each field.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let fields: [CardFieldType: String] = [
    .cardNumber: "4111111111111111",
    .cvv: "123",
    .cardHolderName: "John Doe",
    .expireMonth: "12",
    .expireYear: "2024"
]

let formState = moneyHashSDK.isValidForm(fields: fields)

if formState.isValid {
    print("Form is valid.")
} else {
    print("Form is invalid.")
    for (fieldType, state) in formState.fieldStates {
        if !(state.isValid ?? true) {
            print("Invalid field \(fieldType): \(state.errorMessage ?? "Unknown error")")
        }
    }
}
```

---

### 15. `collect`

```swift
func collect(
    fields: [CardFieldType: String],
    token: String,
    intentID: String,
    shouldSaveCard: Bool
) async throws -> VaultData?
```

- **Description**: Collects card data and attempts to create a vault token if the fields are valid.
- **Parameters**:
  - `fields`: A dictionary of card fields.
  - `token`: Authentication token required for the backend service.
  - `intentID`: A unique identifier for the transaction or intent.
  - `shouldSaveCard`: A Boolean indicating whether or not the card should be saved.
- **Throws**: An error if the data collection or token creation fails.
- **Returns**: An optional `VaultData` if the collection is successful; otherwise, `nil`.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let fields: [CardFieldType: String] = [
    .cardNumber: "4111111111111111",
    .cvv: "123",
    .cardHolderName: "John Doe",
    .expireMonth: "12",
    .expireYear: "2024"
]

Task {
    do {
        let vaultData = try await moneyHashSDK.collect(fields: fields, token: "auth_token", intentID: "intent_id_12345", shouldSaveCard: true)
        if let vaultData = vaultData {
            print("Vault data created successfully: \(vaultData)")
        } else {
            print("Failed to create vault data.")
        }
    } catch {
        print("Error collecting card data: \(error)")
    }
}
```

---

### 16. `setLocale`

```swift
func setLocale(_ locale: MHLocale)
```

- **Description**: Sets the locale for the SDK to handle localization of text presented to the user.
- **Parameters**:
  - `locale`: The `MHLocale` object representing the desired locale for the SDK operations.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
moneyHashSDK.setLocale(.arabic)
```

---

### 17. `updateFees`

```swift
func updateFees(
    intentId: String,
    fees: [FeeItem]
) async throws -> FeesData?
```

- **Description**: Updates fees for a given payment intent.
- **Parameters**:
  - `intentId`: The ID of the payment intent for which fees are being updated.
  - `fees`: A list of `FeeItem` representing the fees to be updated.
- **Throws**: An `MHError` if the update fails.
- **Returns**: A `FeesData` object containing the updated fees details.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let fees: [FeeItem] = [
    FeeItem(title: [.english: "Service Fee"], value: "10", discount: nil)
]

Task {
    do {
        let updatedFees = try await moneyHashSDK.updateFees(intentId: "intent_id_12345", fees: fees)
        if let feesData = updatedFees {
            print("Fees updated successfully: \(feesData)")
        } else {
            print("Failed to update fees.")
        }
    } catch {
        print("Error updating fees: \(error)")
    }
}
```

---

### 18. `updateDiscount`

```swift
func updateDiscount(
    intentId: String,
    discount: DiscountItem
) async throws -> DiscountData?
```

- **Description**: Updates the discount for a given payment intent.
- **Parameters**:
  - `intentId`: The ID of the payment intent for which the discount is being updated.
  - `discount`: The `DiscountItem` detailing the discount to be applied.
- **Throws**: An `MHError` if the update fails.
- **Returns**: A `DiscountData` object

 containing the details of the applied discount.

**Example**:

```swift
let moneyHashSDK: MoneyHashSDK = DefaultMoneyHashSDK()
let discount = DiscountItem(
    title: [.english: "Summer Discount"],
    type: .percentage,
    value: "10"
)

Task {
    do {
        let discountData = try await moneyHashSDK.updateDiscount(intentId: "intent_id_12345", discount: discount)
        if let discountData = discountData {
            print("Discount updated successfully: \(discountData)")
        } else {
            print("Failed to update discount.")
        }
    } catch {
        print("Error updating discount: \(error)")
    }
}
```

---

This API documentation provides detailed descriptions and examples for each method in the `MoneyHashSDK` and Apple Pay services, making it easier for developers to integrate these functionalities into their iOS applications.
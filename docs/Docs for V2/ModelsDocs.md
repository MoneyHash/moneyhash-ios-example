
### MoneyHash SDK Models Documentation

The MoneyHash SDK includes a variety of models that represent different aspects of payment intents, methods, transactions, and more. Below is a detailed explanation of each model and its properties.

#### 1. `MHError`

```swift
public enum MHError: Error {
    case cancelled
    case unknownError(underlyingError: String)
    case error(error: MoneyHashError)
}
```

- **Description**: Represents different types of errors that can occur within the MoneyHash SDK.
- **Cases**:
  - `cancelled`: Indicates that an operation was cancelled.
  - `unknownError(underlyingError: String)`: Represents an unknown error, with an underlying error message.
  - `error(error: MoneyHashError)`: Encapsulates a specific `MoneyHashError`.
---

#### 2. `FieldError`

```swift
public struct FieldError {
    let fieldName: String
    let message: String
}
```

- **Description**: Represents an error related to a specific field.
- **Properties**:
  - `fieldName`: The name of the field that caused the error.
  - `message`: A message describing the error.
---

#### 3. `MethodsResult`

```swift
public struct MethodsResult: Encodable {
    let intentData: IntentDetails?
    let methods: IntentMethods?
}
```

- **Description**: Represents the result of available methods for an intent.
- **Properties**:
  - `intentData`: Contains details about the intent (`IntentDetails`).
  - `methods`: Contains the available payment methods (`IntentMethods`).
---

#### 4. `IntentMethods`

```swift
public struct IntentMethods: Encodable {
    public let customerBalances: [CustomerBalance]?
    public let paymentMethods: [PaymentMethod]?
    public let expressMethods: [ExpressMethod]?
    public let savedCards: [SavedCard]?
    public let payoutMethods: [PayoutMethod]?
}
```

- **Description**: Represents different payment methods available for an intent.
- **Properties**:
  - `customerBalances`: A list of available customer balances (`CustomerBalance`).
  - `paymentMethods`: A list of available payment methods (`PaymentMethod`).
  - `expressMethods`: A list of available express methods (`ExpressMethod`).
  - `savedCards`: A list of saved cards (`SavedCard`).
  - `payoutMethods`: A list of available payout methods (`PayoutMethod`).
---

#### 5. `IntentDetails`

```swift
public struct IntentDetails: Encodable {
    public let selectedMethod: String?
    public let wallet: Double?
    public let intent: Intent?
    public let productItems: [ProductItem]?
    public let state: IntentStateDetails?
    public let transaction: Transaction?
    public let id: String?
    public let nativePayData: NativePayData?
}
```

- **Description**: Provides detailed information about an intent.
- **Properties**:
  - `selectedMethod`: The method selected for the intent.
  - `wallet`: The wallet balance associated with the intent.
  - `intent`: The `Intent` object containing core intent details.
  - `productItems`: A list of items related to the product (`ProductItem`).
  - `state`: The current state of the intent (`IntentStateDetails`).
  - `transaction`: Details about the transaction (`Transaction`).
  - `id`: The unique identifier for the intent.
  - `nativePayData`: Data for native payments like Apple Pay (`NativePayData`).
---

#### 6. `Intent`

```swift
public struct Intent: Encodable {
    public let id: String?
    public let amount: AmountData?
    public let secret: String?
    public let isLive: Bool?
    public let status: IntentStatus?
    public let expirationDate: String?
    public let fees: [FeeItem]?
    public let totalDiscount: String?
    public let subtotalAmount: String?
}
```

- **Description**: Represents the core details of an intent.
- **Properties**:
  - `id`: The unique identifier of the intent.
  - `amount`: The total amount for the intent (`AmountData`).
  - `secret`: A secret key associated with the intent.
  - `isLive`: Indicates if the intent is in live mode.
  - `status`: The current status of the intent (`IntentStatus`).
  - `expirationDate`: The date when the intent expires.
  - `fees`: A list of fees applied to the intent (`FeeItem`).
  - `totalDiscount`: The total discount applied to the intent.
  - `subtotalAmount`: The subtotal amount before any discounts or fees.
---

#### 7. `AmountData`

```swift
public struct AmountData: Encodable {
    public let value: String?
    public let formatted: Double?
    public let currency: String?
    public let maxPayoutAmount: Double?
}
```

- **Description**: Represents the monetary value related to an intent.
- **Properties**:
  - `value`: The raw value of the amount.
  - `formatted`: The formatted amount value.
  - `currency`: The currency code (e.g., "USD").
  - `maxPayoutAmount`: The maximum payout amount allowed.
---

#### 8. `IntentStatus`

```swift
public enum IntentStatus: String, Encodable {
    case processed
    case unprocessed
    case timeExpired
    case closed
}
```

- **Description**: Enum representing the possible statuses of an intent.
- **Cases**:
  - `processed`: The intent has been processed.
  - `unprocessed`: The intent is unprocessed.
  - `timeExpired`: The intent has expired due to time.
  - `closed`: The intent has been closed.
---

#### 9. `IntentType`

```swift
public enum IntentType: String, Encodable {
    case payment
    case payout
}
```

- **Description**: Enum representing the type of an intent.
- **Cases**:
  - `payment`: Represents a payment intent.
  - `payout`: Represents a payout intent.
---

#### 10. `Transaction`

```swift
public struct Transaction: Encodable {
    public let id: String?
    public let createdDate: String?
    public let status: String?
    public let amount: Double?
    public let amountCurrency: String?
    public let method: String?
    public let methodName: String?
    public let billingData: String?
    public let customFields: String?
    public let customFormAnswers: String?
    public let externalActionMessage: [String]?
    public let providerTransactionFields: String?
}
```

- **Description**: Represents details about a transaction within an intent.
- **Properties**:
  - `id`: The unique identifier of the transaction.
  - `createdDate`: The date when the transaction was created.
  - `status`: The current status of the transaction.
  - `amount`: The amount involved in the transaction.
  - `amountCurrency`: The currency of the transaction amount.
  - `method`: The method used for the transaction.
  - `methodName`: The name of the method used.
  - `billingData`: Billing data associated with the transaction.
  - `customFields`: Custom fields related to the transaction.
  - `customFormAnswers`: Answers to any custom forms associated with the transaction.
  - `externalActionMessage`: External action messages, if any.
  - `providerTransactionFields`: Fields specific to the transaction provider.
---

#### 11. `SavedCard`

```swift
public struct SavedCard: Encodable {
    public let id: String?
    public let brand: String?
    public let last4: String?
    public let expiryMonth: String?
    public let expiryYear: String?
    public let country: String?
    public let logo: String?
    public let requireCvv: Bool?
    public let cvvConfig: CvvConfig?
    public let type: IntentMethodType?
}
```

- **Description**: Represents a saved card used in transactions.
- **Properties**:
  - `id`: The unique identifier of the saved card.
  - `brand`: The brand of the card (e.g., Visa, MasterCard).
  - `last4`: The last four digits of the card number.
  - `expiryMonth`: The expiry month of the card.
  - `expiryYear`: The expiry year of the card.
  - `country`: The country where the card was issued.
  - `logo`: The logo associated with the card brand.
  - `requireCvv`: Indicates if CVV is required for this card.
  - `cvvConfig`: Configuration related to CVV input (`CvvConfig`).
  - `type`: The type of method (`IntentMethodType`).
---

#### 12. `PayoutMethod`

```swift
public struct PayoutMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}
```

- **Description**: Represents a payout method available for the user.
- **Properties**:
  - `id`: The unique identifier of the payout method.
  - `title`: The title or name of the payout method.
  - `isSelected`: Indicates if this method is selected.
  - `checkoutIcons`: Icons associated with the payout method.
  - `type`: The type of method (`IntentMethodType`).
---

#### 13. `PaymentMethod`

```swift


public struct PaymentMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}
```

- **Description**: Represents a payment method available for the user.
- **Properties**:
  - `id`: The unique identifier of the payment method.
  - `title`: The title or name of the payment method.
  - `isSelected`: Indicates if this method is selected.
  - `checkoutIcons`: Icons associated with the payment method.
  - `type`: The type of method (`IntentMethodType`).
---

#### 14. `IntentMethodType`

```swift
public enum IntentMethodType: String, Encodable {
    case paymentMethod
    case expressMethod
    case payoutMethod
    case savedCard
    case customerBalance
}
```

- **Description**: Enum representing different types of methods available for an intent.
- **Cases**:
  - `paymentMethod`: Represents a standard payment method.
  - `expressMethod`: Represents an express payment method.
  - `payoutMethod`: Represents a payout method.
  - `savedCard`: Represents a saved card method.
  - `customerBalance`: Represents a customer balance method.
---

#### 15. `IntentMethodMetaData`

```swift
public struct IntentMethodMetaData {
    public let cvv: String?
}
```

- **Description**: Contains metadata related to a payment method, such as CVV.
- **Properties**:
  - `cvv`: The CVV code for a card.
---

#### 16. `ExpressMethod`

```swift
public struct ExpressMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}
```

- **Description**: Represents an express payment method.
- **Properties**:
  - `id`: The unique identifier of the express method.
  - `title`: The title or name of the express method.
  - `isSelected`: Indicates if this method is selected.
  - `checkoutIcons`: Icons associated with the express method.
  - `type`: The type of method (`IntentMethodType`).
---

#### 17. `CustomerBalance`

```swift
public struct CustomerBalance: Encodable {
    public let id: String?
    public let balance: Double?
    public let isSelected: Bool?
    public let icon: String?
    public let type: IntentMethodType?
}
```

- **Description**: Represents a customer balance available for use in an intent.
- **Properties**:
  - `id`: The unique identifier of the customer balance.
  - `balance`: The balance amount.
  - `isSelected`: Indicates if this balance is selected.
  - `icon`: An icon associated with the balance.
  - `type`: The type of method (`IntentMethodType`).
---

#### 18. `ApplePayData`

```swift
public struct ApplePayData: Codable {
    public let countryCode: String?
    public let merchantId: String?
    public let currencyCode: String?
    public let amount: Float?
    public let supportedNetworks: [String]?
}
```

- **Description**: Contains data necessary for configuring an Apple Pay transaction.
- **Properties**:
  - `countryCode`: The country code for the transaction (e.g., "US").
  - `merchantId`: The merchant identifier for Apple Pay.
  - `currencyCode`: The currency code for the transaction (e.g., "USD").
  - `amount`: The amount to be charged.
  - `supportedNetworks`: A list of supported networks for Apple Pay (e.g., Visa, MasterCard).
---

#### 19. `InputField`

```swift
public struct InputField: Encodable {
    public let type: InputFieldType
    public let name: String?
    public var value: String?
    public let optionsList: [OptionItem]?
    public let optionsMap: [String: [OptionItem]]?
    public let label: String?
    public let maxLength: Int?
    public let hint: String?
    public let isRequired: Bool
    public let minLength: Int?
    public let readOnly: Bool
    public let dependsOn: String?
}
```

- **Description**: Represents a field in a form used for collecting user input.
- **Properties**:
  - `type`: The type of the input field (`InputFieldType`).
  - `name`: The name of the input field.
  - `value`: The current value of the input field.
  - `optionsList`: A list of selectable options for the input field (`OptionItem`).
  - `optionsMap`: A map of options for selection.
  - `label`: The label for the input field.
  - `maxLength`: The maximum length of the input.
  - `hint`: A hint message for the input field.
  - `isRequired`: Indicates if the input field is required.
  - `minLength`: The minimum length of the input.
  - `readOnly`: Indicates if the input field is read-only.
  - `dependsOn`: Specifies another field that this field depends on.
---

#### 20. `OptionItem`

```swift
public struct OptionItem: Encodable {
    public let label: String
    public let value: String
}
```

- **Description**: Represents an option item in a selectable list within an input field.
- **Properties**:
  - `label`: The label displayed to the user.
  - `value`: The value associated with the option.
---

#### 21. `InputFieldType`

```swift
public enum InputFieldType: Encodable {
    case text
    case email
    case phoneNumber
    case select
    case number
    case date
}
```

- **Description**: Enum representing the type of an input field.
- **Cases**:
  - `text`: A standard text input field.
  - `email`: An email input field.
  - `phoneNumber`: A phone number input field.
  - `select`: A dropdown or select input field.
  - `number`: A numeric input field.
  - `date`: A date input field.
---

#### 22. `ErrorMessagesData`

```swift
public struct ErrorMessagesData: Encodable {
    public let blank: String?
    public let nullState: String?
    public let minLength: String?
    public let invalid: String?
    public let requiredMessage: String?
    public let maxLength: String?
    public let minValue: String?
    public let maxValue: String?
}
```

- **Description**: Represents custom error messages for validation in forms.
- **Properties**:
  - `blank`: Error message for blank fields.
  - `nullState`: Error message for null state.
  - `minLength`: Error message for inputs shorter than the minimum length.
  - `invalid`: Error message for invalid input.
  - `requiredMessage`: Error message for required fields.
  - `maxLength`: Error message for inputs longer than the maximum length.
  - `minValue`: Error message for values lower than the minimum allowed.
  - `maxValue`: Error message for values higher than the maximum allowed.
---

#### 23. `CardEmbed`

```swift
public struct CardEmbed: Encodable {
    public let accessToken: String?
    public let isLive: Bool?
    public let saveCard: Bool?
    public let saveCardCheckboxMandatory: SaveCardCheckbox?
}
```

- **Description**: Represents the data needed to embed a card in the payment process.
- **Properties**:
  - `accessToken`: An access token used for embedding the card.
  - `isLive`: Indicates if the card is in live mode.
  - `saveCard`: Indicates if the card should be saved.
  - `saveCardCheckboxMandatory`: Configuration for the save card checkbox (`SaveCardCheckbox`).
---

#### 24. `SaveCardCheckbox`

```swift
public struct SaveCardCheckbox: Codable {
    public let mandatory: Bool?
    public let show: Bool?
}
```

- **Description**: Represents the configuration for the save card checkbox.
- **Properties**:
  - `mandatory`: Indicates if the save card option is mandatory.
  - `show`: Indicates if the save card checkbox should be shown.
---

#### 25. `FeeItem`

```swift
public struct FeeItem: Codable {
    public let title: [Language: String]
    public let value: String

    enum CodingKeys: String, CodingKey {
        case title
        case value
    }
}
```

- **Description**: Represents a fee item associated with an intent.
- **Properties**:
  - `title`: The title of the fee in different languages (`Language`).
  - `value`: The value of the fee.
---

#### 26. `Language`

```swift
public enum Language: String, Codable {
    case arabic = "ar"
    case english = "en"
    case french = "fr"

    var isoCode: String {
        return self.rawValue
    }

    static func fromIsoCode(_ isoCode: String) -> Language {
        return Language(rawValue: isoCode) ?? .english
    }
}
```

- **Description**: Enum representing different languages.
- **Cases**:
  - `arabic`: Arabic language.
  - `english`: English language.
  - `french`: French language.
---

#### 27. `LogLevel`

```swift
public enum LogLevel {
    case verbose
    case debug
    case info
    case warning
    case error
    case assert


}
```

- **Description**: Enum representing different levels of logging.
- **Cases**:
  - `verbose`: Detailed debug information.
  - `debug`: General debug information.
  - `info`: General informational messages.
  - `warning`: Warning messages.
  - `error`: Error messages.
  - `assert`: Assertion failures.
---

#### 28. `NativePayData`

```swift
public enum NativePayData: Codable {
    case applePay(MoneyHash.ApplePayData)
}
```

- **Description**: Enum representing data for native payment methods like Apple Pay.
- **Cases**:
  - `applePay(MoneyHash.ApplePayData)`: Data for an Apple Pay transaction.
---

#### 29. `ProductItem`

```swift
public struct ProductItem: Codable {
    let name: String?
    let type: String?
    let amount: String?
    let category: String?
    let quantity: Int?
    let description: String?
    let subcategory: String?
    let referenceId: String?
}
```

- **Description**: Represents an item associated with a product in an intent.
- **Properties**:
  - `name`: The name of the product item.
  - `type`: The type of the product item.
  - `amount`: The amount associated with the product item.
  - `category`: The category of the product item.
  - `quantity`: The quantity of the product item.
  - `description`: A description of the product item.
  - `subcategory`: The subcategory of the product item.
  - `referenceId`: A reference ID associated with the product item.
---

#### 30. `IntentStateDetails`

```swift
public enum IntentStateDetails: Encodable {
    case methodSelection(methods: IntentMethods?)
    case intentForm
    case intentProcessed
    case transactionWaitingUserAction
    case transactionFailed(recommendedMethods: IntentMethods?)
    case expired
    case closed
    case formFields(cardEmbed: CardEmbed?, billingFields: [InputField]?, shippingFields: [InputField]?)
    case redirectToURL(url: String?, renderStrategy: RenderStrategy?)
    case savedCardCVV(cvvField: InputField, cardTokenData: CardTokenData?)
}
```

- **Description**: Enum representing different states an intent can be in.
- **Cases**:
  - `methodSelection(methods: IntentMethods?)`: Represents the method selection state.
  - `intentForm`: Represents the state where the MoneyHash form is rendered.
  - `intentProcessed`: Represents the state where the intent has been processed.
  - `transactionWaitingUserAction`: Represents the state where the transaction is waiting for user action.
  - `transactionFailed(recommendedMethods: IntentMethods?)`: Represents the state where the transaction has failed, with recommended methods provided.
  - `expired`: Represents the state where the intent has expired.
  - `closed`: Represents the state where the intent has been closed.
  - `formFields(cardEmbed: CardEmbed?, billingFields: [InputField]?, shippingFields: [InputField]?)`: Represents the state where form fields are being filled out.
  - `redirectToURL(url: String?, renderStrategy: RenderStrategy?)`: Represents the state where a URL is being redirected.
  - `savedCardCVV(cvvField: InputField, cardTokenData: CardTokenData?)`: Represents the state where a saved card's CVV is being entered.
---

#### 31. `CardTokenData`

```swift
public struct CardTokenData: Codable {
    public let bin: String?
    public let brand: String?
    public let cardHolderName: String?
    public let country: String?
    public let expiryMonth: String?
    public let expiryYear: String?
    public let issuer: String?
    public let last4: String?
    public let logo: String?
    public let paymentMethods: [String?]?
    public let requiresCvv: Bool?
}
```

- **Description**: Represents token data for a card used in payment processing.
- **Properties**:
  - `bin`: The bank identification number (BIN) of the card.
  - `brand`: The brand of the card (e.g., Visa, MasterCard).
  - `cardHolderName`: The name of the cardholder.
  - `country`: The country where the card was issued.
  - `expiryMonth`: The expiry month of the card.
  - `expiryYear`: The expiry year of the card.
  - `issuer`: The issuer of the card.
  - `last4`: The last four digits of the card number.
  - `logo`: The logo associated with the card brand.
  - `paymentMethods`: A list of payment methods associated with the card.
  - `requiresCvv`: Indicates if CVV is required for this card.



---


#### 32. `cardfieldtype`

```swift
public enum CardFieldType {
    case cardNumber      // Represents the card number field.
    case cvv             // Represents the CVV field.
    case cardHolderName  // Represents the cardholder name field.
    case expireMonth     // Represents the expiration month field.
    case expireYear      // Represents the expiration year field.
}
```
**Description**: An enumeration representing the different types of card fields.

- **Enum Cases**:
  - `cardNumber`: Represents the card number field.
  - `cvv`: Represents the CVV field.
  - `cardHolderName`: Represents the cardholder name field.
  - `expireMonth`: Represents the expiration month field.
  - `expireYear`: Represents the expiration year field.

---

#### 33. `CardInputFieldState`

```swift
public struct CardInputFieldState {
    public let isValid: Bool?
    public let errorMessage: String?
    public let isOnFocused: Bool
    
    public init(isValid: Bool? = nil, errorMessage: String? = nil, isOnFocused: Bool = false) {
        self.isValid = isValid
        self.errorMessage = errorMessage
        self.isOnFocused = isOnFocused
    }
    
    public static let defaultState = CardInputFieldState(isValid: nil, errorMessage: nil, isOnFocused: false)
}
```
- **Description**: Represents the card field state.
- **Properties**:
  - `isValid: Bool?`
    - Indicates whether the input in the field is valid. This is useful for real-time validation and providing feedback to the user.
  - `errorMessage: String?`
    - Contains an error message associated with the input field, which can be displayed to the user if the input is invalid.
  - `isOnFocused: Bool`
    - Indicates whether the input field is currently focused. This can be used to manage the UI, such as highlighting the focused field.

- **Initializer**:
  - `init(isValid: Bool? = nil, errorMessage: String? = nil, isOnFocused: Bool = false)`
    - Initializes a new instance of `CardInputFieldState` with optional parameters for validity, error message, and focus state.

- **Default State**:
  - `CardInputFieldState.defaultState`
    - Provides a default state for the card input field where all properties are set to their initial values (`isValid` and `errorMessage` are `nil`, and `isOnFocused` is `false`).

- **Usage**:
  - This model is typically used in conjunction with `CardFormCollector` to manage the state of each field in a card form, allowing the application to validate input, display error messages, and adjust UI behavior based on the field’s focus status.

  Here’s how you can add the `ApplePayStatus` model documentation to the `ModelsDocs.md` file:


---

### 34. ApplePayStatus

```swift
public enum ApplePayStatus: Error {
    /// The device is not compatible with Apple Pay.
    case notCompatible
    /// The Apple Pay transaction failed.
    case failed
}
```

- **Description**: An enum representing possible statuses for Apple Pay transactions.
- **Enum Cases**:
  - `notCompatible`: Indicates that the device is not compatible with Apple Pay.
  - `failed`: Indicates that the Apple Pay transaction failed.


---

This documentation provides a comprehensive overview of the models used in the MoneyHash SDK, including explanations of each model and its properties.
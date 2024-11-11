
# MoneyHash SDK Models Documentation

The MoneyHash SDK includes a variety of models that represent different aspects of payment intents, methods, transactions, and more. Below is a detailed explanation of each model and its properties.

---

### 1. `MHError`

```swift
public struct MHError: Error, Codable {
    /// The category of the error.
    public let type: ErrorType
    /// A human-readable message describing the error.
    public let message: String
    /// A list of additional error details.
    public let errors: [ErrorInfo]
}
```

- **Description**: Represents different types of errors that can occur within the MoneyHash SDK.
- **Properties**:
  - `type`: The category of the error (`ErrorType`).
  - `message`: A human-readable message describing the error.
  - `errors`: Additional error details represented as an array of `ErrorInfo`.

---

### 2. `ErrorType`

```swift
public enum ErrorType: String, Codable {
    case cancelled
    case cardValidation = "card_validation"
    case network
    case unknown
    case notCompatibleWithApplePay
    case applePayTransactionFailed
}
```

- **Description**: Enum representing the different categories of errors.
- **Cases**:
  - `cancelled`: Indicates that an operation was cancelled.
  - `cardValidation`: Represents a card validation error.
  - `network`: Represents a network error.
  - `unknown`: Represents an unknown error.
  - `notCompatibleWithApplePay`: Indicates the device is not compatible with Apple Pay.
  - `applePayTransactionFailed`: Indicates the Apple Pay transaction failed.

---

### 3. `ErrorInfo`

```swift
public struct ErrorInfo: Codable {
    /// The key identifying the specific error detail.
    public let key: String
    /// A descriptive message pertaining to the error.
    public let message: String
}
```

- **Description**: Represents additional details related to a specific error.
- **Properties**:
  - `key`: Identifies the specific error detail.
  - `message`: A descriptive message pertaining to the error.

---

### 4. `Language`

```swift
public enum Language: String, Codable, CodingKey {
    /// Represents the Arabic language.
    case arabic = "ar"
    /// Represents the English language.
    case english = "en"
    /// Represents the French language.
    case french = "fr"
}
```

- **Description**: Enum representing different languages supported by the SDK.
- **Cases**:
  - `arabic`: Arabic language.
  - `english`: English language.
  - `french`: French language.

---

### 5. `FeeItem`

```swift
public struct FeeItem: Codable {
    /// A dictionary containing the title of the fee in different languages.
    public let title: [Language: String]?
    /// The value of the fee as a string.
    public let value: String?
    /// The data for the discount on this fee if it exists.
    public let discount: DiscountItem?
}
```

- **Description**: Represents a fee item associated with an intent.
- **Properties**:
  - `title`: The title of the fee in different languages.
  - `value`: The value of the fee.
  - `discount`: The discount applied to this fee (`DiscountItem`).

---

### 6. `FeesData`

```swift
public struct FeesData: Codable {
    /// The total amount before any fees are applied.
    public let amount: String?
    /// An array of `FeeItem` objects detailing the individual fees applied, each containing a title in multiple languages and a value.
    public let fees: [FeeItem]?
}
```

- **Description**: Represents the fee data for an intent.
- **Properties**:
  - `amount`: The total amount before any fees are applied.
  - `fees`: An array of individual fee items applied to the transaction.

---

### 7. `DiscountType`

```swift
public enum DiscountType: String, Codable {
    /// A discount type that subtracts a fixed amount from the total.
    case amount = "amount"
    /// A discount type that subtracts a percentage of the total.
    case percentage = "percentage"
}
```

- **Description**: Enum representing the type of discount applied.
- **Cases**:
  - `amount`: Represents a fixed amount discount.
  - `percentage`: Represents a percentage discount.

---

### 8. `DiscountItem`

```swift
public struct DiscountItem: Codable {
    /// A dictionary mapping `Language` enum values to localized strings, providing the title of the discount in different languages.
    public let title: [Language: String]?
    /// The type of the discount, indicating whether it is a fixed amount or a percentage.
    public let type: DiscountType?
    /// The numerical value of the discount, which could be an amount or a percentage based on the type.
    public let value: String?
}
```

- **Description**: Represents the details of a discount applied to a fee or transaction.
- **Properties**:
  - `title`: The title of the discount in different languages.
  - `type`: The type of the discount (amount or percentage).
  - `value`: The value of the discount.

---

### 9. `DiscountData`

```swift
public struct DiscountData: Codable {
    /// The total amount that the discount is applied to, before the discount is subtracted.
    public let amount: String?
    /// The detailed discount applied, returned by the server after the update. Contains the title in multiple languages, type, and value of the discount.
    public let discount: DiscountItem?
}
```

- **Description**: Represents the discount information related to a transaction.
- **Properties**:
  - `amount`: The total amount before the discount is applied.
  - `discount`: The detailed discount applied to the transaction.

---

### 10. `IntentDetails`

```swift
public struct IntentDetails: Codable {
    /// The selected payment or payout method for the intent.
    public let selectedMethod: String?
    /// The associated wallet balance.
    public let wallet: Double?
    /// The `Intent` object containing the primary details.
    public let intent: Intent?
    /// A list of product items included in the intent.
    public let productItems: [ProductItem]?
    /// The current state of the intent.
    public let state: IntentStateDetails?
    /// The transaction details associated with the intent.
    public let transaction: Transaction?
    /// The unique identifier for the intent.
    public let id: String?
}
```

- **Description**: Provides detailed information about an intent.
- **Properties**:
  - `selectedMethod`: The selected payment or payout method for the intent.
  - `wallet`: The wallet balance associated with the intent.
  - `intent`: The `Intent` object containing core intent details.
  - `productItems`: A list of product items included in the intent.
  - `state`: The current state of the intent.
  - `transaction`: Details about the transaction associated with the intent.
  - `id`: The unique identifier for the intent.

---

### 11. `TokenizeCardInfo` (Previously `CardEmbed`)

```swift
public struct TokenizeCardInfo: Codable {
    /// An access token for card tokenizing.
    public let accessToken: String?
    /// Indicates whether the card tokenizing is in live mode or staging.
    public let isLive: Bool?
    /// Indicates whether the card should be saved.
    public let saveCard: Bool?
    /// Information about the save card checkbox.
    public let saveCardCheckboxMandatory: SaveCardCheckbox?
}
```

- **Description**: Represents the data needed to tokenize and embed a card in the payment process.
- **Properties**:
  - `accessToken`: An access token used for card tokenizing.
  - `isLive`: Indicates whether the card tokenizing is in live mode or staging.
  - `saveCard`: Indicates whether the card should be saved.
  - `saveCardCheckboxMandatory`: Configuration for the save card checkbox.

---

### 12. `MHLocale`

```swift
public enum MHLocale: String, Codable {
    case arabic = "ar"
    case english = "en"
    case french = "fr"
}
```

- **Description**: Enum representing different locales supported by the SDK.
- **Cases**:
  - `arabic`: Arabic locale.
  - `english`: English locale.
  - `french`: French locale.

---

### 13. `CardBrand`

```swift
public struct CardBrand: Codable {
    public let first6Digits: String
    public let brand: String
    public let brandIconUrl: String
}
```

- **Description**: Represents a card brand and its associated details.
- **Properties**:
  - `first6Digits`: The first six digits of the card number.
  - `brand`: The brand name (e.g., Visa, MasterCard).
  - `brandIconUrl`: The URL to the brand’s icon.

---

### 14. `VaultData`

```swift
public struct VaultData: Codable {
    /// The first six digits of the card number.
    public let firstSixDigits: String?
    /// The last four digits of the card number.
    public let lastFourDigits: String?
    /// The card scheme (e.g., Visa, MasterCard).
    public let cardScheme: String?
    /// The name of the cardholder.
    public let cardHolderName: String?
    /// The expiry year of the card.
    public let expiryYear

: String?
    /// The expiry month of the card.
    public let expiryMonth: String?
    /// Indicates whether the card is live.
    public let isLive: Bool?
    /// The access token associated with the card.
    public let accessToken: String?
    /// The token representing the card.
    public let cardToken: String?
    /// The CVV of the card.
    public let cvv: String?
    /// Indicates whether the card should be saved.
    public let saveCard: Bool?
    /// The fingerprint of the card.
    public let fingerprint: String?
}
```

- **Description**: Represents the vault data related to a stored card.
- **Properties**:
  - `firstSixDigits`: The first six digits of the card number.
  - `lastFourDigits`: The last four digits of the card number.
  - `cardScheme`: The card scheme (e.g., Visa, MasterCard).
  - `cardHolderName`: The name of the cardholder.
  - `expiryYear`: The expiry year of the card.
  - `expiryMonth`: The expiry month of the card.
  - `isLive`: Indicates whether the card is live.
  - `accessToken`: The access token associated with the card.
  - `cardToken`: The token representing the card.
  - `cvv`: The CVV of the card.
  - `saveCard`: Indicates whether the card should be saved.
  - `fingerprint`: The fingerprint of the card.

---

### 15. `RenderStrategy`

```swift
public enum RenderStrategy: Codable {
    /// Redirect strategy.
    case redirect
    /// Popup IFrame strategy.
    case popupIFrame
    /// IFrame strategy.
    case iframe
    /// No render strategy.
    case none
}
```

- **Description**: Enum representing different rendering strategies during the payment process.
- **Cases**:
  - `redirect`: Redirect strategy.
  - `popupIFrame`: Popup IFrame strategy.
  - `iframe`: IFrame strategy.
  - `none`: No render strategy.

---

### 16. `FieldError`

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

### 17. `MethodsResult`

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

### 18. `IntentMethods`

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

### 19. `Intent`

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

### 20. `AmountData`

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

### 21. `IntentStatus`

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

### 22. `IntentType`

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

### 23. `Transaction`

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

### 24. `SavedCard`

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

### 25. `PayoutMethod`

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
  - `type`: The type

 of method (`IntentMethodType`).

---

### 26. `PaymentMethod`

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

### 27. `IntentMethodType`

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

### 28. `IntentMethodMetaData`

```swift
public struct IntentMethodMetaData {
    public let cvv: String?
}
```

- **Description**: Contains metadata related to a payment method, such as CVV.
- **Properties**:
  - `cvv`: The CVV code for a card.

---

### 29. `ExpressMethod`

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

### 30. `CustomerBalance`

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

### 31. `ApplePayData`

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

### 32. `InputField`

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

### 33. `OptionItem`

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

### 34. `InputFieldType`

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

### 35. `ErrorMessagesData`

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

### 36. `CardTokenData`

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

### 37. `CardFieldType`

```swift
public enum CardFieldType {
    case cardNumber      // Represents the card number field.
    case cvv             // Represents the CVV field.
    case cardHolderName  // Represents the cardholder name field.
    case expireMonth     // Represents the expiration month field.
    case expireYear      // Represents the expiration year field.
}
```

- **Description**: An enumeration representing the different types of card fields.
- **Enum Cases**:
  - `cardNumber`: Represents the card number field.
  - `cvv`: Represents the CVV field.
  - `cardHolderName`: Represents the cardholder name field.
  - `expireMonth`: Represents the expiration month field.
  - `expireYear`: Represents the expiration year field.

---

### 38. `CardInputFieldState`

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
  - `isValid`: Indicates whether the input in the field is valid.
  - `errorMessage`: Contains an error message associated with the input field.
  - `isOnFocused`: Indicates whether the input field is currently focused.

---

### 39. `ApplePayStatus`

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
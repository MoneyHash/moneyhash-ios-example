# How to use MoneyHash iOS

### Requirements

- Requires Xcode 14.3 or above

## Installation

Add a package by selecting `File` → `Add Packages…` in Xcode’s menu bar.

<img src="docs/swiftpm_step1.png">

---

Search for the MoneyHash SDK using the repo's URL:
```console
https://github.com/MoneyHash/moneyhash-ios
```

Next, set the **Dependency Rule** to be `Up to Next Major Version` and specify `1.0.6` as the lower bound.

Then, select **Add Package**.

<img src="docs/swiftpm_step2.png">

---

## How to use?

- Create moneyHash instance using `MoneyHashSDKBuilder`

```swift
import MoneyHash

let moneyHashSDK = MoneyHashSDKBuilder.build()
```

> MoneyHash SDK guides to for the actions required to be done, to have seamless integration through intent details `state`

| state                             | Action                                                                                                                                                                                          |
| :-------------------------------- |:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `METHOD_SELECTION`                | Use `moneyHash.getIntentMethod` to get different intent methods and render them natively with your own styles & use `moneyHash.proceedWithMethod` to proceed with one of them on user selection |
| `INTENT_FORM`                     | Use `moneyHash.renderForm` to start the SDK flow to let MoneyHash handle the flow for you & listen for result by using IntentContract() for Activity result                                     |
| `INTENT_PROCESSED`                | Render your successful confirmation UI with the intent details                                                                                                                                  |
| `TRANSACTION_FAILED`              | Render your failure UI with the intent details                                                                                                                                                  |
| `TRANSACTION_WAITING_USER_ACTION` | Render your pending actions confirmation UI with the intent details & `externalActionMessage` if exists on `Transaction`                                                                        |
| `EXPIRED`                         | Render your intent expired UI                                                                                                                                                                   |
| `CLOSED`                          | Render your intent closed UI                                                                                                                                                                    |

- Get intent details based on the intent id and type (Payment/Payout)

```swift
        self.moneyHashSDK.getIntentDetails(
            intentId: "Z1ED7zZ",
            intentType: IntentType.payment) { result in
            do {
                let intentDetails = try result.get()
                print(try intentDetails.convertToDictionary())
            } catch {
                print("Error: \(error)")
            }
        }
```

- Get intent available payment/payout methods, saved cards and customer balances

```swift
        self.moneyHashSDK.getIntentMethods(
            intentId: "Z1ED7zZ",
            intentType: IntentType.payment) { result in
            do {
                let intentMethods = try result.get()
                print(try intentMethods
                    .convertToDictionary())
            } catch {
                print("Error: \(error)")
            }
        }
```

- Proceed with a payment/payout method, card or wallet

```swift
        self.moneyHashSDK.proceedWithMethod(
            intentId: "Z1ED7zZ",
            intentType: IntentType.payment,
            selectedMethodId: "methodId",
            methodType: IntentMethodType.expressMethod, // method type that returned from the intent methods
            metaData: nil // optional and can be null (cvv is required for customer saved cards that requires cvv)
        ) { result in
             // handle the intent methods native UI and updated intent details
        }
```

- Reset the selected method on and intent to null

> Can be used for `back` button after method selection
> or `retry` button on failed transaction UI to try a different
> method by the user.

```swift
        self.moneyHashSDK.resetSelectedMethod(
            intentId: "Z1ED7zZ",
            intentType: IntentType.payment
        ) { result in
                
        }
```

- Delete a customer saved card

```swift
        self.moneyHashSDK.deleteSavedCard(
            cardTokenId: "cardTokenId", // card token id that returned in savedCards list in IntentMethods
            intentSecret: "intentSecret" // intent secret that returned in intent details
        ) { result in
                
        }
```

- Render SDK embed forms and payment/payout integrations

> Must be called if `state` of an intent is `INTENT_FORM` to let MoneyHash handle the payment/payout.

> you can also use it directly to render the embed form for payment/payout without handling the methods selection native UI.

```swift
            self.moneyHashSDK.renderForm(
                on: self,
                intentId: "intentId",
                embedStyle: embedStyle, // optional EmbedStyle object to customize the embed form UI (colors, fonts, etc) for the buttons, inputs, loader
                intentType: IntentType.payment
            ) { result in
                do {
                    // Handle result here
                } catch MHError.cancelled {
                    print("Cancelled")
                } catch {
                    print(String(describing: result))
                }
            }
```

### Models
```swift

public enum MHError: Error {
    case cancelled
    case unknownError(underlyingError: String)
}

public struct MethodsResult: Encodable {
    let intentData: IntentDetails?
    let methods: IntentMethods?
}

public struct IntentMethods: Encodable {
    public let customerBalances: [CustomerBalance]?
    public let paymentMethods: [PaymentMethod]?
    public let expressMethods: [ExpressMethod]?
    public let savedCards: [SavedCard]?
    public let payoutMethods: [PayoutMethod]?
}

public struct IntentDetails: Encodable {
    public let selectedMethod: String?
    public let wallet: Double?
    public let intent: Intent?
    public let state: State?
    public let transaction: Transaction?
    public let redirect: RedirectData?
}

public struct Intent: Encodable {
    public let id: String?
    public let amount: AmountData?
    public let secret: String?
    public let isLive: Bool?
    public let status: IntentStatus?
    public let expirationDate: String?
}

public struct AmountData: Encodable {
    let value: String?
    let formatted: Double?
    let currency: String?
    let maxPayoutAmount: Double?
}

public enum IntentStatus: String, Encodable {
    case processed
    case unprocessed
    case timeExpired
    case closed
}

public enum IntentType: String, Encodable {
    case payment
    case payout
}

public struct RedirectData: Encodable {
    public let redirectUrl: String?
}

public enum State: String, Encodable {
    case methodSelection
    case intentForm
    case intentProcessed
    case transactionWaitingUserAction
    case transactionFailed
    case expired
    case closed
}

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

public struct PayoutMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}

public struct PaymentMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}

public enum IntentMethodType: String, Encodable {
    case paymentMethod
    case expressMethod
    case payoutMethod
    case savedCard
    case customerBalance
}

public struct IntentMethodMetaData {
    public let cvv: String?
}

public struct ExpressMethod: Encodable {
    public let id: String?
    public let title: String?
    public let isSelected: Bool?
    public let checkoutIcons: [String]?
    public let type: IntentMethodType?
}

public struct CustomerBalance: Encodable {
    public let id: String?
    public let balance: Double?
    public let isSelected: Bool?
    public let icon: String?
    public let type: IntentMethodType?
}

```


## Questions and Issues

Please provide any feedback via a [GitHub Issue](https://github.com/MoneyHash/moneyhash-ios/issues/new?template=bug_report.md).

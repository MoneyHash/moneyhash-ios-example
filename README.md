# How to use MoneyHash iOS

## About MoneyHash

MoneyHash is a Super-API infrastructure for payment orchestration and revenue operations in emerging markets. We provide a single integration to your network of pay-in and pay-out providers, and various other services that you can utilize and combine to build a unique custom payment stack. Our core features include:

1. A single API/SDK integration for Pay-in & Pay-out
2. Unified checkout embed compatible with all integrated providers
3. Orchestration and routing capabilities to allow for optimal transaction routes and to increase authorization rates
4. Micro-services to extend your stack capabilities such as subscription management, invoicing, and payment links
5. PCI-compliant card vault to store and tokenize sensitive customer and card information
6. Central dashboard for unified stack controls and transaction reporting

You can learn more about us by visiting [our website](https://www.moneyhash.io/).

## Requirements

- Requires Xcode 12.5 or above

## Installation

Add a package by selecting `File` → `Add Packages…` in Xcode’s menu bar.

<img src="docs/swiftpm_step1.png">

---

Search for the MoneyHash SDK using the repo's URL:
```console
https://github.com/MoneyHash/moneyhash-ios
```

Next, set the **Dependency Rule** to be `Up to Next Major Version` and specify `0.1.1` as the lower bound.

Then, select **Add Package**.

<img src="docs/swiftpm_step2.png">

---

### Create a Payment/Payout Intent
You will need to create a Payment Intent and use it's ID to initiate the SDK, There are two ways to create a Payment/Payout Intent:

- **Using The Sandbox**

  Which is helpful to manually and quickly create a Payment/Payout Intent without having to running any backend code. For more information about the Sandbox refer to this [section](https://moneyhash.github.io/sandbox)
- **Using The Payment Intent API**

  This will be the way your backend server will eventually use to create a Payment Intents, for more information refer to this [section](https://moneyhash.github.io/api)

### Usage

To start the payment flow use the Payment Intent ID from the step above as a parameter

1- import MoneyHash to your view controller
```swift
import MoneyHash
```

2- 

```swift
        MHPaymentHandler.startPaymentFlow(
            on: self,
            withPaymentId: paymentIntentId // Your payment intent id
        ) { status in
            switch status {
            case .error(errors: let errors):
                print("errors")
            case .failed:
                print("failed")
            case .requireExtraAction(actions: let actions):
                print("actions")
            case .redirect(let result, let redirectUrl):
                print("redirect")
            case .success:
                print("success")
            case .redirect(result: let result, redirectUrl: let redirectUrl):
                print("success")
            case .cancelled:
                print("cancelled")
            case .unknown:
                print("unknown")
            @unknown default:
                print("unknown")
            }
        }
```

To start the payout flow use the Payout Intent ID from the step above as a parameter

1- import MoneyHash to your view controller
```swift
import MoneyHash
```

2- 

```swift
        MHPaymentHandler.startPayoutFlow(
            on: self,
            withPayoutId: payoutIntentId // Your payout intent id
        ) { status in
            switch status {
            case .error(errors: let errors):
                print("errors")
            case .failed:
                print("faild")
            case .requireExtraAction(actions: let actions):
                print("actions")
            case .success:
                print("success")
            case .redirect(result: let result, redirectUrl: let redirectUrl):
                print("success")
            case .cancelled:
                print("cancelled")
            case .unknown:
                print("unknown")
            @unknown default:
                print("unknown")
            }
        }
```

### Payment/Payout Statuses
Once your customer finishes adding the payment information they will reach one of the following statuses, and  a callback is fired with the payment status which indicate the current status of your payment.

Status | #
--- | ---
Error | There was an error while processing the payment and more details about the errors will be found inside errors data.
Success | The payment is Successful.
RequireExtraAction | That payment flow is done and the customer needs to do some extra actions off the system, a list of the actions required by the customer will be found inside the actions data, and it should be rendered to the customer in your app.
Failed | There was an error while processing the payment.
Unknown | There was an unknown state received and this should be checked from your MoneyHash dashboard.
Redirect | That payment flow is done and the customer needs to be redirected to `redirectUrl`.
Cancelled | The customer cancelled the payment flow by clicking back or cancel.

## Questions and Issues

Please provide any feedback via a [GitHub Issue](https://github.com/MoneyHash/moneyhash-ios/issues/new?template=bug_report.md).

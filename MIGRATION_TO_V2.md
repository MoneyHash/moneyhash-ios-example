Here's the updated migration guide with examples migrating from to V2:

# Migration Guide: MoneyHash iOS SDK

This guide provides step-by-step instructions for migrating from the old version of the MoneyHash iOS SDK to the new version. The changes involve updates to method signatures, the introduction of new states, and the addition of new methods.

---

## 1. Replace Old Method Calls

### Get Intent Details

**Old:**
```swift
self.moneyHashSDK.getIntentDetails(
    intentId: "Z1ED7zZ",
    intentType: .payment) { result in
        do {
            let intentDetails = try result.get()
            print(try intentDetails.convertToDictionary())
        } catch {
            print("Error: \(error)")
        }
    }
```

**New:**
```swift
do {
    let intentDetails = try await self.moneyHashSDK.getIntentDetails(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print(try intentDetails.convertToDictionary())
} catch {
    print("Error: \(error)")
}
```

### Get Available Payment/Payout Methods

**Old:**
```swift
self.moneyHashSDK.getIntentMethods(
    intentId: "Z1ED7zZ",
    intentType: .payment) { result in
        do {
            let intentMethods = try result.get()
            print(try intentMethods.convertToDictionary())
        } catch {
            print("Error: \(error)")
        }
    }
```

**New:**
```swift
do {
    let intentMethods = try await self.moneyHashSDK.getIntentMethods(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print(try intentMethods.convertToDictionary())
} catch {
    print("Error: \(error)")
}
```

### Proceed with a Payment/Payout Method

**Old:**
```swift
self.moneyHashSDK.proceedWithMethod(
    intentId: "Z1ED7zZ",
    intentType: .payment,
    selectedMethodId: "methodId",
    methodType: .expressMethod, 
    metaData: nil) { result in
        // Handle result
    }
```

**New:**
```swift
do {
    let methodsResult = try await self.moneyHashSDK.proceedWithMethod(
        intentId: "Z1ED7zZ",
        intentType: .payment,
        selectedMethodId: "methodId",
        methodType: .expressMethod,
        metaData: nil
    )
    print(try methodsResult.convertToDictionary())
} catch {
    print("Error: \(error)")
}
```

### Reset the Selected Method

**Old:**
```swift
self.moneyHashSDK.resetSelectedMethod(
    intentId: "Z1ED7zZ",
    intentType: .payment) { result in
        // Handle result
    }
```

**New:**
```swift
do {
    let methodsResult = try await self.moneyHashSDK.resetSelectedMethod(
        intentId: "Z1ED7zZ",
        intentType: .payment
    )
    print(try methodsResult.convertToDictionary())
} catch {
    print("Error: \(error)")
}
```

### Delete a Customer Saved Card

**Old:**
```swift
self.moneyHashSDK.deleteSavedCard(
    cardTokenId: "cardTokenId",
    intentSecret: "intentSecret") { result in
        // Handle result
    }
```

**New:**
```swift
do {
    let success = try await self.moneyHashSDK.deleteSavedCard(
        cardTokenId: "cardTokenId",
        intentSecret: "intentSecret"
    )
    if success {
        print("Card deleted successfully")
    }
} catch {
    print("Error: \(error)")
}
```

### Render SDK Embed Forms and Payment/Payout Integrations

**Old:**
```swift
self.moneyHashSDK.renderForm(
    on: self,
    intentId: "intentId",
    embedStyle: embedStyle, 
    intentType: .payment) { result in
        do {
            // Handle result
        } catch MHError.cancelled {
            print("Cancelled")
        } catch {
            print(String(describing: result))
        }
    }
```

**New:**
```swift
do {
    let intentDetails = try await self.moneyHashSDK.renderForm(
        on: self,
        intentId: "intentId",
        embedStyle: embedStyle,
        intentType: .payment
    )
    // Handle result here
} catch {
    print("Error: \(error)")
}
```

---

## 2. Migrate Old States to New States

### Old States and Their New Equivalents

| Old State                           | New State                            | Associated Variables                                                                 |
| :---------------------------------- | :----------------------------------- | :----------------------------------------------------------------------------------- |
| `METHOD_SELECTION`                  | `methodSelection`                    | `methods`: `IntentMethods?` (contains information about all available methods)       |
| `INTENT_FORM`                       | `intentForm`                         | None                                                                                 |
| `INTENT_PROCESSED`                  | `intentProcessed`                    | None                                                                                 |
| `TRANSACTION_FAILED`                | `transactionFailed`                  | `recommendedMethods`: `IntentMethods?` (recommended methods if the transaction fails) |
| `TRANSACTION_WAITING_USER_ACTION`   | `transactionWaitingUserAction`       | `externalActionMessage`: `String?` (if exists on `Transaction`)                      |
| `EXPIRED`                           | `expired`                            | None                                                                                 |
| `CLOSED`                            | `closed`                             | None                                                                                 |

### Code Examples

**Handling the Old State:**

```swift
switch intentDetails.state {
case .METHOD_SELECTION:
    // Handle method selection state
    // Use moneyHashSDK.getIntentMethods to get available methods
case .INTENT_FORM:
    // Handle intent form state
    // Use moneyHashSDK.renderForm to render the form
case .INTENT_PROCESSED:
    // Handle intent processed state
    // Render successful confirmation UI
case .TRANSACTION_FAILED:
    // Handle transaction failed state
    // Render failure UI
case .TRANSACTION_WAITING_USER_ACTION:
    // Handle transaction waiting user action state
    // Render pending actions confirmation UI
case .EXPIRED:
    // Handle expired state
    // Render intent expired UI
case .CLOSED:
    // Handle closed state
    // Render intent closed UI
default:
    break
}
```

**Handling the New State:**

```swift
switch intentDetails.state {
case .methodSelection(let methods):
    // Handle method selection state with the associated methods
    // Render methods natively with your own styles
case .intentForm:
    // Handle intent form state
    // Use moneyHashSDK.renderForm to render the form
case .intentProcessed:
    // Handle intent processed state
    // Render successful confirmation UI
case .transactionFailed(let recommendedMethods):
    // Handle transaction failed state with the associated recommended methods
    // Render failure UI with recommended methods
case .transactionWaitingUserAction(let externalActionMessage):
    // Handle transaction waiting user action state with the associated external action message
    // Render pending actions confirmation UI
case .expired:
    // Handle expired state
    // Render intent expired UI
case .closed:
    // Handle closed state
    // Render intent closed UI
case .formFields(let cardEmbed, let billingFields, let shippingFields):
    // Handle form fields state
    // Render form with the provided fields
case .redirectToURL(let url, let renderStrategy):
    // Handle redirect to URL state
    // Redirect user to the provided URL
case .savedCardCVV(let cvvField, let cardTokenData):
    // Handle saved card CVV state
    // Collect and submit CVV
default:
    break
}
```

---

## 3. Add Support for New Methods

### Submit Form Data

Use this method to submit additional form data, including billing and shipping information, as well as card data.

```swift
do {
    let intentDetails = try await self.moneyHashSDK.submitForm(
        intentID: "",
        selectedMethod: "",
        billingData: nil,
        shippingData: nil,
        cardData: nil
    )
    // Handle the updated intent details
} catch {
    // Handle error
}
```

### Send CVV for Saved Card

This method is used to send the CVV for a saved card associated with an intent.

```swift
do {
    let intentDetails = try await self.moneyHashSDK.sendCVV(
        intentID: "",
        cvv: ""
    )
    // Handle the updated intent details
} catch {
    // Handle error
}
```

### Set Log Level

Set the minimum log level to be displayed in the console by the SDK.

```swift
self.moneyHashSDK.setLogLevel(logLevel: .debug)
```

### Submit Payment Receipt

Submit a payment receipt for an intent (usually an Apple Pay receipt).

```swift
do {
    let intentDetails = try await self.moneyHashSDK.submitPaymentRecipet(
        intentId: "",
        data: ""
    )
    // Handle the updated intent details
} catch {
    // Handle error
}
```

---

## 4. Update Error Handling

In the new SDK, errors are now handled using Swift's `throw` mechanism. You'll need to update your error handling code to use `do-catch` blocks.

### Example of Updated Error Handling

```swift
do {
    let res = try await moneyHashSDK.submitForm(
        intentID: "",
        selectedMethod: "",
        billingData:

 nil,
        shippingData: nil,
        cardData: nil
    )
    // Handle success
} catch {
    if let error = error as? MHError {
        switch error {
        case .cancelled:
            print("Cancelled")
        case .unknownError(let underlyingError):
            print("Unknown error with underlying error \(underlyingError)")
        case .error(let moneyHashError):
            print((moneyHashError.userInfo["errors"] as? Array<FieldError>)!)
        }
    }
    print(error)
}
DispatchQueue.main.async {
    // Update UI on the main thread
}
```

---

## Summary

This migration guide provides the necessary steps to update your codebase from the old `MoneyHashSDK` to the new version. Ensure your project is updated with these changes to take full advantage of the new SDK capabilities.

For further assistance, please refer to the updated [MoneyHash iOS SDK Documentation](https://github.com/MoneyHash/moneyhash-ios).
```

This guide now includes detailed steps for migrating state handling and error handling, along with examples for each.
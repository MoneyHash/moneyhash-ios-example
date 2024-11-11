//
//  ViewController.swift
//  Demo
//
//  Created by Ahmed Elzeiny on 10/02/2022.
//

import UIKit
import SwiftUI
import MoneyHash

class ViewController: UIViewController {

    // Initialize MoneyHashSDK with a public key
    let moneyHashSDK = MoneyHashSDKBuilder()
        .setPublicKey("Add Your Account Public Key")
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create buttons with custom styling and set actions
        let renderButton = createStyledButton(title: "Render Payment Intent")
        renderButton.addTarget(self, action: #selector(renderFormButtonTapped), for: .touchUpInside)

        let renderPayoutButton = createStyledButton(title: "Render Payout Intent")
        renderPayoutButton.addTarget(self, action: #selector(renderPayoutFormButtonTapped), for: .touchUpInside)
        
        let showSwiftUIButton = createStyledButton(title: "Pay With Card")
        showSwiftUIButton.addTarget(self, action: #selector(openSwiftUIViewButtonTapped), for: .touchUpInside)

        // Add buttons to the view hierarchy
        view.addSubview(renderButton)
        view.addSubview(renderPayoutButton)
        view.addSubview(showSwiftUIButton)
        
        // Disable autoresizing mask translation for Auto Layout
        renderButton.translatesAutoresizingMaskIntoConstraints = false
        showSwiftUIButton.translatesAutoresizingMaskIntoConstraints = false
        renderPayoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Apply Auto Layout constraints for positioning and sizing
        NSLayoutConstraint.activate([
            // CenterX constraints for buttons
            renderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            renderPayoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showSwiftUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Vertical positioning for buttons
            renderButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            renderPayoutButton.topAnchor.constraint(equalTo: renderButton.bottomAnchor, constant: 20),
            showSwiftUIButton.topAnchor.constraint(equalTo: renderPayoutButton.bottomAnchor, constant: 20),
            
            // Width constraints for consistent button sizes
            renderButton.widthAnchor.constraint(equalToConstant: 250),
            renderPayoutButton.widthAnchor.constraint(equalToConstant: 250),
            showSwiftUIButton.widthAnchor.constraint(equalToConstant: 250),
            
            // Height constraints for consistent button sizes
            renderButton.heightAnchor.constraint(equalToConstant: 50),
            renderPayoutButton.heightAnchor.constraint(equalToConstant: 50),
            showSwiftUIButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Method to create a styled UIButton
    private func createStyledButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        return button
    }
    
    // Action to render the payout form
    @objc func renderPayoutFormButtonTapped() {
        DispatchQueue.main.async {
            self.moneyHashSDK.renderForm(
                on: self,
                intentId: "your payoutIntentID",
                embedStyle: nil,
                intentType: .payout
            ) { res in
                print(res) // Print the result for debugging
            }
        }
    }

    // Action to render the payment form
    @objc func renderFormButtonTapped() {
        DispatchQueue.main.async {
            self.moneyHashSDK.renderForm(
                on: self,
                intentId: "your intentID",
                embedStyle: nil,
                intentType: .payment
            ) { res in
                print(res) // Print the result for debugging
            }
        }
    }
    
    // Action to open a SwiftUI view in a UIHostingController
    @objc func openSwiftUIViewButtonTapped() {
        let cardVM = createCardFormVM() // Create the ViewModel instance
        let cardFormView = CardFormView(cardFormVM: cardVM) // Initialize the SwiftUI view
        let hostingController = UIHostingController(rootView: cardFormView)
        self.present(hostingController, animated: true, completion: nil) // Present the view controller
    }

    // Method to create a CardFormVM instance, enabling dependency injection
    private func createCardFormVM() -> CardFormVM {
        return CardFormVM()
    }
}


#if DEBUG
extension EmbedStyle {
    internal static var getTestSample:EmbedStyle {
       EmbedStyle(
            submitButton: EmbedButtonStyle(
                base: EmbedButtonViewStyle(
                    color: "white",
                    fontFamily: "Arial",
                    fontWeight: "bold",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px",
                    textTransform: "uppercase",
                    letterSpacing: "0.5px",
                    background: "#FF0000",
                    padding: "10px 20px",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px"
                ),
                hover: EmbedButtonViewStyle(
                    color: "white",
                    fontFamily: "Arial",
                    fontWeight: "bold",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px",
                    textTransform: "uppercase",
                    letterSpacing: "0.5px",
                    background: "#FF0000",
                    padding: "10px 20px",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px"
                ),
                focus: EmbedButtonViewStyle(
                    color: "white",
                    fontFamily: "Arial",
                    fontWeight: "bold",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px",
                    textTransform: "uppercase",
                    letterSpacing: "0.5px",
                    background: "#FF0000",
                    padding: "10px 20px",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px"
                )
            ),
            loader: EmbedLoaderStyle(
                backgroundColor: "black",
                color: "white"
            ),
            input: EmbedInputStyle(
                base: EmbedInputViewStyle(
                    height: "40px",
                    padding: "10px",
                    background: "#FFFFFF",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px",
                    color: "#000000",
                    fontFamily: "Arial",
                    fontWeight: "normal",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px"
                ),
                error: EmbedInputViewStyle(
                    height: "40px",
                    padding: "10px",
                    background: "#FFFFFF",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px",
                    color: "#000000",
                    fontFamily: "Arial",
                    fontWeight: "normal",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px"
                ),
                focus: EmbedInputViewStyle(
                    height: "40px",
                    padding: "10px",
                    background: "#FFFFFF",
                    borderRadius: "4px",
                    boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                    borderStyle: "none",
                    borderColor: "#FF0000",
                    borderWidth: "1px",
                    color: "#000000",
                    fontFamily: "Arial",
                    fontWeight: "normal",
                    fontSize: "16px",
                    fontSmoothing: "antialiased",
                    lineHeight: "24px"
                )
            )
        )

    }
}


#endif



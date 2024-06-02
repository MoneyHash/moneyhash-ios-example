//
//  ViewController.swift
//  Demo
//
//  Created by Ahmed Elzeiny on 10/02/2022.
//

import UIKit
import MoneyHash

class ViewController: UIViewController {

    let moneyHashSDK = MoneyHashSDKBuilder.build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.moneyHashSDK.renderForm(
                on: self,
                intentId: "your intentID",
                embedStyle: EmbedStyle.getTestSample,
                intentType: .payment
            ) { res in
                print(res)
            }
        }
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



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
                intentId: "Z1ED7zZ",
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
        }
    }
}


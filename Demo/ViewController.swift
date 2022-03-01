//
//  ViewController.swift
//  Demo
//
//  Created by Ahmed Elzeiny on 10/02/2022.
//

import UIKit
import MoneyHash

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            MHPaymentHandler.start(
                on: self,
                withPaymentId: "Your payment id will be here",
                andEnvironment: .staging
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
                case .cancelled:
                    print("cancelled")
                case .unknown:
                    print("unknown")
                @unknown default:
                    print("unknown")
                }
            }
        }
        
       
        
    }


}


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
            MHPaymentHandler.startPaymentFlow(
                on: self,
                withPaymentId: "rgyBeaZ"
            ) { result in
                switch result {
                case .redirect(let result, let redirectUrl):
                    print(String(describing: redirectUrl))

                case .success(let result):
                    fallthrough

                case .requireExtraAction(_, let result):
                    fallthrough

                    
                case .failed(let result):
                    fallthrough

                case .error:
                    fallthrough
                    
                case .cancelled:
                    fallthrough
                    
                default:
                    print(String(describing: result))
                }
            }
        }
    }
}


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
                withPaymentId: "PgwXvOZ"
            ) { result in
                switch result {
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


//
//  BaseViewController.swift
//  Tip Calculator
//
//   Created by Tolga telseren on 09/01/18.
//  Copyright © 2018 Tolga telseren. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        func addTap() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.tapped(tap:)))
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc func tapped(tap: UITapGestureRecognizer) {
            view.endEditing(true)
        }
        
}

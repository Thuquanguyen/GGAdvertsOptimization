//
//  LoginVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/27/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    // MARK: - Properties
    var failedLoginAttempts: Int = 0
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionLoginFB(_ sender: Any) {
        let vc = LoginSucessVC()
        self.push(vc)
    }
}

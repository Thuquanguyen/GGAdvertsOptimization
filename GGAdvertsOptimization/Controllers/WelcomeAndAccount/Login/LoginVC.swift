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
    @IBOutlet weak var facebookView: UIView!
    
    var failedLoginAttempts: Int = 0
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionLoginFB(_ sender: Any) {
        let webVC = WebViewController()
        webVC.openMainScreen = {
//            self.openMainScreen()
        }
        self.push(webVC)
    }
}

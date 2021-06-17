//
//  NotificationVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionSetting(_ sender: Any) {
        self.showMainPopupConfirm(message: "Sorry!\nFunction is under development")
    }
    
    @IBAction func actionFilter(_ sender: Any) {
        self.showMainPopupConfirm(message: "Sorry!\nFunction is under development")
    }
}

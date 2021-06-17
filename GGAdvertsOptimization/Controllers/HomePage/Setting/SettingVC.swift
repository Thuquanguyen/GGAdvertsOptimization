//
//  SettingVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func actionClick(_ sender: Any) {
        self.showMainPopupConfirm(message: "Sorry!\nFunction is under development")
    }
}

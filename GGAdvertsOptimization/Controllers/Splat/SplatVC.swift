//
//  SplatVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/21/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class SplatVC: UIViewController {

    @IBOutlet weak var imageCover2: UIImageView!
    @IBOutlet weak var imageCover: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatus()
    }
}
extension SplatVC{
    private func getStatus(){
        GetStatusAPI().execute(target: self, success: {[unowned self] res in
            DispatchQueue.main.async {
                self.imageCover.image = UIImage(named: (res.status) ? "ic_facebook" : "AppIcon")
                self.imageCover2.image = UIImage(named: (res.status) ? "logo_flast_bottom" : "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    AppDelegate.shared.getStatus(status: res.status )
                })
            }
        }, failure: {[unowned self] error in
            self.showMainPopupConfirm(message: "An error has occurred! Please try again!")
        })
    }
}

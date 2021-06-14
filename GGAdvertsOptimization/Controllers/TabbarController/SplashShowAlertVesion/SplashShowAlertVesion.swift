//
//  SplashShowAlertVesion.swift
//  YTeThongMinh
//
//  Created by QuanNH on 7/30/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class SplashShowAlertVesion: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewButtonOptional: UIView!
    @IBOutlet weak var viewButtonNonOptional: UIView!
    
    var requiredUpdate: Int?
    var link: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = "Bạn cần cập nhật lên phiên bản ứng dụng mới nhất"
        if let requiredUpDate = requiredUpdate {
            viewButtonOptional.isHidden = !(requiredUpDate == 2)
            viewButtonNonOptional.isHidden = requiredUpDate == 2
            if requiredUpDate == 2 {
                labelTitle.text = "Đã có phiên bản mới của ứng dụng. Bạn có mốn cập nhật không"
            }
        }
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        AppDelegate.shared.checkApp()
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        Utils.openUrl(string: link ?? "")
    }
}

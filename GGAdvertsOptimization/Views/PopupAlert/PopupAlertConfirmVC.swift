//
//  PopupAlertVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/29/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class PopupAlertConfirmVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var buttonConfirm: UIButton!
    
    // MARK: - Properties
    var message: String?
    var titlePopup: String?
    var titleConfirm = ""
    
    // MARK: - Closures
    var didClickButton: (() -> Void)?
    
    // MARK: - ViewController's life cycles
    deinit {
        print("Deinit PopupAlertConfirmVC")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.isHidden = titlePopup == nil
        titleLabel.text = titlePopup
        labelMessage.text = message
        labelMessage.set(lineSpacing: 5)
        if titleConfirm != "" {
            buttonConfirm.setTitle(titleConfirm, for: .normal)
        }
    }
    
    func set(message: String?, titleButton: String?) {
        self.message = message
        if let title = titleButton {
            titleConfirm = title
        }
    }

    // MARK: - Actions
    @IBAction func buttonConfirm(_ sender: Any) {
        remove()
        didClickButton?()
        AppDelegate.shared.removeAlertWindow()
    }
}

//
//  PopupAlertVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/29/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class PopupAlertVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    
    // MARK: - Properties
    var message: String?
    var titlePopup: String?
    var titleButtonLeft: String?
    var titleButtonRight: String?
    
    // MARK: - Closures
    var didClickButton: ((_ isRight: Bool) -> Void)?
    
    // MARK: - ViewController's life cycles
    deinit {
        print("Deinit PopupAlertVC")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        labelMessage.text = message
        labelTitle.text = titlePopup
        if let left = titleButtonLeft {
            buttonLeft.setTitle(left, for: .normal)
        }
        if let right = titleButtonRight {
            buttonRight.setTitle(right, for: .normal)
        }
    }
    
    func set(title: String?, message: String?) {
        self.message = message
        self.titlePopup = title
    }
    
    func setTitleButton(left: String?, right: String?) {
        titleButtonLeft = left
        titleButtonRight = right
    }

    // MARK: - Actions
    @IBAction func actionLeft(_ sender: Any) {
        remove()
        didClickButton?(false)
    }
    
    @IBAction func actionRight(_ sender: Any) {
        remove()
        didClickButton?(true)
    }
}

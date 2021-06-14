//
//  PopupAlertVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/29/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class PopupAlertImageVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var message: String?
    var image: UIImage?
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
        imageView.image = image
        labelMessage.text = message
        if let left = titleButtonLeft {
            buttonLeft.setTitle(left, for: .normal)
        }
        if let right = titleButtonRight {
            buttonRight.setTitle(right, for: .normal)
        }
    }
    
    func set(image: UIImage?, message: String?) {
        self.image = image
        self.message = message
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

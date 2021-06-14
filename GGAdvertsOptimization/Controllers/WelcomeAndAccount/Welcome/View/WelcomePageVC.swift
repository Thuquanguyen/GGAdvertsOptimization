//
//  WelcomePageVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/27/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class WelcomePageVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    
    // MARK: - Properties
    var index: Int = 0
    var image: UIImage?
    var titleScreen = ""
    var contentScreen = ""

    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = titleScreen
        imageContent.image = image
        labelContent.text = contentScreen
    }

}

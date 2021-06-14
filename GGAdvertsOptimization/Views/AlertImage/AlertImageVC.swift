//
//  AlertImageVC.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 7/8/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class AlertImageVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initData(url: String){
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "history_imageIcon"))
    }
    
    // MARK: - Actions
    @IBAction func actionCloseButtonTapped(_ sender: Any) {
        self.remove()
    }
}

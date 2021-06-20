//
//  CreateCampainVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class CreateCampainVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Properties
    let tabVC = BaseTabBarVC()
    let createView = CreateViewVC()
    let duplicatieView = DuplicateViewVC()
    let draftView = DraftsViewVC()
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
}

extension CreateCampainVC {
    // Function setup tabbar
    private func setupTab(){
        tabVC.tabStyle = .fit
        tabVC.titles = ["Create New","Duplicate","Drafts"]
        tabVC.bindingPage = {[unowned self] index in
            if index == 0 {
                return self.createView
            }else if index == 1 {
                return self.duplicatieView
            }else{
                return self.draftView
            }
        }
        addViewController(vc: tabVC, viewBase: contentView)
    }
}

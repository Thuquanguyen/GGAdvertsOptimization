//
//  TabbarController.swift
//  XKLD
//
//  Created by PhucND-GD on 2/24/20.
//  Copyright © 2020 vinhdd. All rights reserved.
//

import UIKit


class TabbarController: BubbleTabBarController {
    
    // MARK: - Properties
    private let height: CGFloat = 60.0
    
    lazy var homeVC: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_home".localized(), image: UIImage(named: "ic_tabbar_home"), selectedImage: UIImage(named: "ic_tabbar_home"))
        let nav = BaseNavigationVC(rootViewController: vc)
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    lazy var notificationVC: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_notification".localized(), image: UIImage(named: "ic_tabbar_notification"), selectedImage: UIImage(named: "ic_tabbar_notification"))
        let nav = BaseNavigationVC(rootViewController: vc)
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    lazy var personalVC: UIViewController = {
        let vc = UIViewController()
        vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_personal".localized(), image: UIImage(named: "ic_tabbar_personal"), selectedImage: UIImage(named: "ic_tabbar_personal"))
        let nav = BaseNavigationVC(rootViewController: vc)
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBar = tabBar as? ESTabBar {
            tabBar.barTintColor = UIColor.init("#E1F5FE")
            tabBar.itemCustomPositioning = .fillIncludeSeparator
            let safeArea: CGFloat = SystemInfo.safeAreaInsetBottom
            tabBar.itemEdgeInsets = .init(top: 0, left: 0, bottom: safeArea, right: 0)
            tabBar.backgroundImage = UIImage(color: UIColor("#F86E84"))
        }
        viewControllers = [homeVC, notificationVC, personalVC]
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: "ChangeLanguage"), object: nil, queue: .main) { (n) in

            let homeVC: UIViewController = {
                let vc = UIViewController()
                vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_home".localized(), image: UIImage(named: "ic_tabbar_home"), selectedImage: UIImage(named: "ic_tabbar_home"))
                let nav = BaseNavigationVC(rootViewController: vc)
                nav.isNavigationBarHidden = true
                return nav
            }()
            self.homeVC = homeVC
            
            let notificationVC: UIViewController = {
                let vc = UIViewController()
                vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_notification".localized(), image: UIImage(named: "ic_tabbar_notification"), selectedImage: UIImage(named: "ic_tabbar_notification"))
                let nav = BaseNavigationVC(rootViewController: vc)
                nav.isNavigationBarHidden = true
                return nav
            }()
            self.notificationVC = notificationVC
            
            let personalVC: UIViewController = {
                let vc = UIViewController()
                vc.tabBarItem = ESTabBarItem.init(TabbarContentView(), title: "tab_bar_personal".localized(), image: UIImage(named: "ic_tabbar_personal"), selectedImage: UIImage(named: "ic_tabbar_personal"))
                let nav = BaseNavigationVC(rootViewController: vc)
                nav.isNavigationBarHidden = true
                return nav
            }()
            self.personalVC = personalVC
            
            self.viewControllers = [homeVC, notificationVC, personalVC]
        }
    }
    
}

//
//  TabbarVC.swift
//  XKLD
//
//  Created by SonDT-D1 on 5/11/20.
//  Copyright © 2020 RikkeiSoft. All rights reserved.
//

import UIKit
import Alamofire

class TabbarVC: BaseVC {
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabbarView: TabbarView!
    
    // MARK: - Properties
    var topVC: UIViewController? {
        return currentIndexSelected < self.subScreenList.count
            ? (self.subScreenList[currentIndexSelected] as? UINavigationController)?.viewControllers.last
            : nil
    }
    var currentIndexSelected = 0
    var subScreenList: [UIViewController] = []
    
    lazy var homeVC: UIViewController = {
        let vc = HomePageVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    lazy var notificationVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    lazy var addScheduleVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    lazy var personalVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        let nav = BaseNavigationVC(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    lazy var remindVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    // MARK: - ViewController's life cycles
    deinit {
        print("Deinit \(self.name)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func networkStatusChange(_ notification: Notification) {
        
    }
    
    private func setup() {
        subScreenList = [homeVC, notificationVC, addScheduleVC, remindVC, personalVC]
        
        self.setSubView(index: currentIndexSelected)
        tabbarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabbarView.didClickButton = { [unowned self] index in
            if self.currentIndexSelected == index && index == 0 {
                self.subScreenList[index].popToRoot(animated: true)
            } else {
                self.setSubView(index: index)
            }
        }
    }
    
    private func setSubView(index: Int) {
        self.removeView(removeView: self.subScreenList[self.currentIndexSelected])
        self.switchView(toView: self.subScreenList[index])
        self.currentIndexSelected = index
    }
    
    func switchView(toView: UIViewController){
        toView.willMove(toParent: self)
        self.addChild(toView)
        self.contentView.addSubview(toView.view)
        toView.didMove(toParent: self)
        toView.view.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
    }
    
    func removeView(removeView: UIViewController){
        removeView.willMove(toParent: nil)
        removeView.view.removeFromSuperview()
        removeView.removeFromParent()
        removeView.didMove(toParent: nil)
    }
}

extension UIViewController {
    func showMainPopup(title: String?, message: String?, leftAction: (()->Void)? = nil, rightAction: (()->Void)? = nil, leftTitle: String? = nil, rightTitle: String? = nil ) {
        let vc = PopupAlertVC()
        vc.didClickButton = { isRight in
            isRight ? rightAction?() : leftAction?()
        }
        vc.set(title: title ?? "Thông báo", message: message)
        vc.setTitleButton(left: leftTitle, right: rightTitle)
        if AppDelegate.shared.window?.rootViewController?.presentedViewController == nil {
            AppDelegate.shared.window?.rootViewController?.addViewController(vc: vc, viewBase: AppDelegate.shared.window?.rootViewController?.view ?? UIView())
        } else {
            UIViewController.top()?.addViewController(vc: vc, viewBase: UIViewController.top()?.view ?? UIView())
        }
    }
    
    func showMainPopupConfirm(title: String? = nil, message: String?, okAction: (()->Void)? = nil, okTitle: String? = nil) {
        let vc = PopupAlertConfirmVC()
        vc.didClickButton = {
            okAction?()
        }
        vc.set(message: message, titleButton: okTitle)
        vc.titlePopup = title
        AppDelegate.shared.makeAlertWindow(vc: vc)
    }
    
    func showMainPopupImage(image: UIImage?, message: String?, leftAction: (()->Void)? = nil, rightAction: (()->Void)? = nil, leftTitle: String? = nil, rightTitle: String? = nil ) {
        let vc = PopupAlertImageVC()
        vc.didClickButton = { isRight in
            isRight ? rightAction?() : leftAction?()
        }
        vc.set(image: image, message: message)
        vc.setTitleButton(left: leftTitle, right: rightTitle)
        if AppDelegate.shared.window?.rootViewController?.presentedViewController == nil {
            AppDelegate.shared.window?.rootViewController?.addViewController(vc: vc, viewBase: AppDelegate.shared.window?.rootViewController?.view ?? UIView())
        } else {
            UIViewController.top()?.addViewController(vc: vc, viewBase: UIViewController.top()?.view ?? UIView())
        }
    }
}

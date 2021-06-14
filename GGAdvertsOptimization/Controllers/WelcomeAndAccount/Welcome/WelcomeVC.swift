//
//  WelcomeVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/27/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var basePageView: UIView!
    
    // MARK: - Properties
    var page: UIPageViewController!
    var imageNames: [String] = ["welcome0","welcome1","welcome2"]
    var titleScreens: [String] = ["Step 1".localized,
                                  "Step 2".localized,
                                  "Step 3".localized]
    var contentScreens: [String] = ["Connect account".localized,
                                  "Get goolge coupon".localized,
                                  "Click on the icon to copy the promo code".localized]
    var indexPage = 0
    static var timer: Timer?
    
    // MARK: - ViewController's life cycles
    deinit {
        WelcomeVC.timer?.invalidate()
        WelcomeVC.timer = nil
        print("Deinit \(self.name)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupPage()
        setupTimer()
    }
    
    func setupVC(){
        let images = [image0, image1, image2]
        images.forEach { (image) in
            image?.setCorner(4)
            image?.backgroundColor = .blue
        }
        images[0]?.backgroundColor = .orange
    }
    
    func setupPage(){
        page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.dataSource = self
        page.delegate = self
        if let view = page.view {
            basePageView.addSubview(view)
        }
        page.view.frame = CGRect(x: 0, y: 0, width: basePageView.width, height: basePageView.height)
        page.setViewControllers([getPage(index: 0) ?? UIViewController()], direction: .forward, animated: false, completion: nil)
    }
    
    func setupTimer(){
        WelcomeVC.timer?.invalidate()
        WelcomeVC.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] (timer) in
            var index = (self?.indexPage ?? 0) + 1
            var direction = UIPageViewController.NavigationDirection.forward
            direction = index >= 3 ? .reverse : .forward
            index = index >= 3 ? 0 : index
            self?.page.setViewControllers([self?.getPage(index: index) ?? UIViewController()], direction: direction, animated: true, completion: nil)
            self?.indexPage = index
            self?.setPageControl(index: index)
            if index == 2 {
                self?.buttonStart.setTitle("DONE", for: .normal)
            }else{
                self?.buttonStart.setTitle("NEXT", for: .normal)
            }
        })
    }

    // MARK: - Actions
    @IBAction func buttonSkip(_ sender: Any) {
        AppDelegate.shared.makeLogin()
    }
    
    @IBAction func buttonContinue(_ sender: Any) {
        AppDelegate.shared.makeLogin()
    }
    
}

// MARK: - UIPageViewController Delegate
extension WelcomeVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func getPage(index: Int) -> WelcomePageVC? {
        if index == -1 || index == imageNames.count {
            return nil
        }
        let vc = WelcomePageVC()
        vc.index = index
        if imageNames.count > index {
            vc.image = UIImage(imageNames[index])
            vc.titleScreen = titleScreens[index]
            vc.contentScreen = contentScreens[index]
        }
        if index == 2 {
            self.buttonStart.setTitle("DONE", for: .normal)
        }else{
            self.buttonStart.setTitle("NEXT", for: .normal)
        }
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = (viewController as? WelcomePageVC) {
            return getPage(index: vc.index - 1)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = (viewController as? WelcomePageVC) {
            return getPage(index: vc.index + 1)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if let vc = pageViewController.viewControllers?.first {
                if let index = (vc as? WelcomePageVC)?.index {
                    setupTimer()
                    indexPage = index
                    setPageControl(index: index)
                    if index == 2 {
                        self.buttonStart.setTitle("DONE", for: .normal)
                    }else{
                        self.buttonStart.setTitle("NEXT", for: .normal)
                    }
                }
            }
        }
    }
    
    func setPageControl(index: Int) {
        let images = [image0,image1,image2]
        images.forEach { (image) in
            image?.backgroundColor = UIColor.blue
        }
        if images.count > index {
            images[index]?.backgroundColor = .orange
        }
    }
}

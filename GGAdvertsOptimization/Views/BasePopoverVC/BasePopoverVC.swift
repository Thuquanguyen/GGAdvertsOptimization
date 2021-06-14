//
//  BasePopoverVC.swift
//  PopoverVCSample
//
//  Created by TrungHD-D1 on 07.12.19.
//  Copyright © 2019 TrungHD. All rights reserved.
//

import UIKit

enum PopoverAnimationType {
    case scaleIn
}

class BasePopoverVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightContainerConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var animatePopup: Bool = true
    private var animationType: PopoverAnimationType = .scaleIn
    
    // MARK: - ViewController's life cycles
    init(animate: Bool = true, animationType: PopoverAnimationType = .scaleIn, nibName: String = "BasePopoverVC") {
        self.animatePopup = animate
        self.animationType = animationType
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setBackgroundColor()
        addGestureForSubviews()
        
        showPopup()
    }

    private func setupSubviews() {
        containerView.layer.cornerRadius = 4.0
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
    }
    
    private func addGestureForSubviews() {
        view.addSingleTapGesture(target: self, selector: #selector(dismissPopup))
        containerView.addSingleTapGesture(target: self, selector: #selector(doNothing))
    }
}


//MARK: SETUP SUBVIEWS
extension BasePopoverVC {
    ///Set background color for full screen
    func setBackgroundColor(color: UIColor = .black, alpha: CGFloat = 0.5) {
        view.backgroundColor = color.withAlphaComponent(alpha)
    }
    
    /// If true, user can tap to outside to dismiss view controller. Default is true
    func canTapOutsideToDismiss(_ enable: Bool) {
        view.isUserInteractionEnabled = enable
    }
    
    private func setAnimationType(type: PopoverAnimationType) {
        animationType = type
    }
}


//MARK: ACTION
extension BasePopoverVC {
    @objc private func showPopup() {
        if animatePopup {
            showWithScaleInAnimation()
        }
    }
    
    @objc func dismissPopup() {
        if animatePopup {
            switch animationType {
            case .scaleIn:
                hideWithScaleInAnimation()
            }
        } else {
            view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @objc private func doNothing() {}
}


//MARK: ANIMATION TYPE
extension BasePopoverVC {
    //SCALE-IN
    private func showWithScaleInAnimation() {
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self?.view.alpha = 1.0
        })
    }
    
    private func hideWithScaleInAnimation() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self?.view.alpha = 0.0
        }) { [weak self] (finished) in
            if finished {
                self?.view.removeFromSuperview()
            }
        }
    }
    
    //OTHER
}

//
//  MarkerView.swift
//  AIC Utilities People
//
//  Created by IchNV-D1 on 5/14/19.
//  Copyright © 2019 Rikkeisoft. All rights reserved.
//

import UIKit

class MarkerView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var markerImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = UINib(nibName: "MarkerView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.autoresizesSubviews = false
        self.addSubview(view)
    }
    
}

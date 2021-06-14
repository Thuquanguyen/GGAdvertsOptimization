//
//  TravelTagCell.swift
//  TetViet
//
//  Created by QuangLH on 12/26/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit

class MapCateCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - View's life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        iconImageView.setCorner(iconImageView.bounds.height / 2)
        containerView.setCorner(containerView.bounds.height / 2)
        containerView.setShadowAroundView()
    }
    
    func config( isSelect: Bool, isOnTop: Bool) {
        backgroundImageView.image = "cell_bg_image".image
        titleLabel.textColor = (isSelect || isOnTop) ? UIColor("4C5054") : UIColor.textColor
        backgroundImageView.isHidden = !isSelect || isOnTop
        categoryView.setCorner(self.bounds.height / 2)
        self.contentView.alpha = (!isSelect && isOnTop) ? 0.5 : 1
        containerView.backgroundColor = (!isSelect && isOnTop) ? UIColor("FAF9F9") : .white 
    }
    
    func configMap( isSelect: Bool, isOnTop: Bool) {
        backgroundImageView.image = "cell_bg_image".image
        titleLabel.textColor = (isSelect || isOnTop) ? UIColor("4C5054") : UIColor.textColor
        backgroundImageView.isHidden = !isSelect || isOnTop
        categoryView.setCorner(7, isborder: (isSelect && isOnTop))
        if (!isSelect && isOnTop) {
           
        } else {
            
        }
        //self.contentView.alpha = (!isSelect && isOnTop) ? 0.5 : 1
    }
    
}

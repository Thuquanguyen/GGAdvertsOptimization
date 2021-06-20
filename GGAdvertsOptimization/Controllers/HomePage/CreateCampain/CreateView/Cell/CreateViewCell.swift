//
//  CreateViewCell.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/19/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class CreateViewCell: UITableViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func initData(data: QuestionModel){
        imageCover.image = UIImage(named: data.imageCover)
        labelTitle.text = data.title
        labelSubtitle.text = data.subTitle
    }
}

//
//  SickHistorySelectCell.swift
//  YTeThongMinh
//
//  Created by QuanNH on 6/12/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class PopupSelectListCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var buttonViewSelect: UIButton!
    @IBOutlet weak var labelTitle: UILabel!

    // MARK: - Properties
    var didClickAtIndex: ((_ index: Int, _ isSelect: Bool) -> Void)?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Actions
    @IBAction func buttonSelect(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        buttonViewSelect.setImage("ic_checked".image, for: .selected)
        buttonViewSelect.isSelected = !buttonViewSelect.isSelected
        didClickAtIndex?(index, buttonViewSelect.isSelected)
    }
}

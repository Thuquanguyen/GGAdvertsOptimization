//
//  NoDataView.swift
//  Rocket.Chat
//
//  Created by DaiLNT- D3 on 7/28/19.
//  Copyright © 2019 Rocket.Chat. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    // MARK: - Closures
    private var btnAction: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func setupView(image: UIImage? = UIImage(named: "ic_nodata"), title: String = "Không tìm thấy kết quả",
                   detail: String = "Rất tiếc, chúng tôi không tìm thấy kết quả nào phù hợp", btnTitle: String? = nil, btnAction: (()->())? = nil) {
        imageView.image = image
        titleLabel.text = title
        detailLabel.text = detail
        btnAdd.setTitle(btnTitle, for: .normal)
        btnAdd.isHidden = btnTitle?.isEmpty ?? true
        self.btnAction = btnAction
    }
    
    func commonInitialization() {
        let view = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
        ])
        view.isUserInteractionEnabled = true
        btnAdd.addTarget(self, action: #selector(btnDidTap(_:)), for: .touchUpInside)
        setupView()
    }
    
    @objc private func btnDidTap(_ sender: UIButton) {
        btnAction?()
    }
}

//
//  TabbarView.swift
//  ATMCard
//
//  Created by SnowLuvQ on 4/7/19.
//  Copyright © 2019 quannh. All rights reserved.
//

import UIKit

class TabbarView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var label0: UILabel!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var image0: UIImageView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet weak var viewBoundImage2: UIView!
    @IBOutlet weak var viewUnreadMessage: UIView!
    @IBOutlet weak var labelUnreadMessage: UILabel!
    
    // MARK: - Properties
    var listButton: [UIButton] = []
    var listLabel: [UILabel] = []
    var listTitle: [String] = ["Home".localized, "Campain".localized, "Notification".localized, "Q&A".localized, "Setting".localized]
    var listImage: [UIImageView] = []
    private let highlightColor = UIColor.white
    private let normalColor = UIColor.white
    private let font = UIFont(name: "Roboto-Bold", size: 8)
    
    // MARK: - Closures
    var didClickButton: ((_ index: Int) -> Void) = {_ in}
    
    // MARK: - ViewController's life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    private func loadXib() {
        guard let view = UINib(nibName: "TabbarView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
        self.listImage = [image0,image1,image2,image3,image4]
        self.listButton = [button0,button1,button2,button3,button4]
        self.listLabel = [label0,label1,label2,label3,label4]
        view.backgroundColor = UIColor.clear
        
        //Set Shadow
//        viewBoundImage2.setCorner(radius: 24.5)
//        viewBoundImage2.setShadow(c: UIColor.black.alpha(0.4), oW: 0, oH: 2, r: 3)
        self.setShadow(c: UIColor.black.alpha(0.2), oW: 0, oH: 4, r	: 5)
    }
    
    func setupUnreadMessage(number: Int){
        viewUnreadMessage.isHidden = !(number > 0)
        labelUnreadMessage.text = number > 9 ? "9+": "\(number)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for index in 0..<self.listImage.count {
            self.listImage[index].image = UIImage(named: "Image_Tabbar_" + String(index))
            self.listImage[index].tintColor = normalColor
            self.listButton[index].tag = index
            self.listLabel[index].text =  self.listTitle[index]
            self.listLabel[index].textColor = normalColor
            self.listLabel[index].font = font
        }
        self.listImage[0].tintColor = highlightColor
        self.listLabel[0].textColor = highlightColor
        self.listImage[0].image = UIImage(named: "Image_Tabbar_" + String(0) + String(-1))
    }
    
    func setClickAtIndex(index: Int, changeStateOnly: Bool = false) {
        if listImage.count <= index { return }
        let button = UIButton()
        button.tag = index
        setState(indexSelect: index)
        if !changeStateOnly {
            didClickButton(button)
        }
    }
    
    // MARK: - Actions
    @IBAction func didClickButton(_ sender: UIButton) {
        if listImage.count <= sender.tag { return }
        setState(indexSelect: sender.tag)
        self.didClickButton(sender.tag)
    }
    
    private func setState(indexSelect: Int) {
        if listImage.count <= indexSelect { return }
        for index in 0..<self.listImage.count {
            self.listImage[index].tintColor = normalColor
            self.listLabel[index].textColor = normalColor
            self.listImage[index].image = UIImage(named: "Image_Tabbar_\(index)")
        }
        self.listImage[indexSelect].tintColor = highlightColor
        self.listLabel[indexSelect].textColor = highlightColor
        self.listImage[indexSelect].image = UIImage(named: "Image_Tabbar_\(indexSelect)-1")
    }
}

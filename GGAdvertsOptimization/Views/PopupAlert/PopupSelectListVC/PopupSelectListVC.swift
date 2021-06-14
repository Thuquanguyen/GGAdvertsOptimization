//
//  PopupAlertVC.swift
//  YTeThongMinh
//
//  Created by QuanNH on 5/29/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class PopupSelectListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var tableView: BaseTableView!
    @IBOutlet weak var textView: BaseTextView!
    @IBOutlet weak var constraintHeightTextView: NSLayoutConstraint!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    
    // MARK: - Properties
    var message: String?
    var hiddenTextIfNotSelect: Bool = false
    var titleButtonLeft: String?
    var titleButtonRight: String?
    var dataSource: [SelectListModel] = []
    
    // MARK: - Closures
    var didClickButton: ((_ isRight: Bool, _ data: [SelectListModel]) -> Void)?
    var didSelectItem: ((String?, Bool)->Void)?
    
    // MARK: - ViewController's life cycles
    deinit {
        print("Deinit PopupAlertVC")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let last = dataSource.last {
            if last.type == .another {
                self.constraintHeightTextView.constant = 76
                textView.text = last.anotherContent
                textView.set(placeHolder: last.placeholder ?? "")
            }
        }
        refeshTextView(index: dataSource.count - 1)
        tableView.registerCellNib(PopupSelectListCell.self)
        labelMessage.text = message
        if let left = titleButtonLeft {
            buttonLeft.setTitle(left, for: .normal)
        }
        if let right = titleButtonRight {
            buttonRight.setTitle(right, for: .normal)
        }
        tableView.didChangeContentSize = {[unowned self] size in
            self.heightTableView.constant = CGFloat.minimum(self.view.height * 0.5, size.height)
        }
    }
    
    func set(title: String?) {
        self.title = message
    }
    
    func setTitleButton(left: String?, right: String?) {
        titleButtonLeft = left
        titleButtonRight = right
    }

    // MARK: - Actions
    @IBAction func actionLeft(_ sender: Any) {
        if var item = dataSource.last {
            if item.type == .another {
                item.anotherContent = textView.text
            }
        }
        didClickButton?(false, dataSource.filter({ $0.isSelected }))
        remove()
    }
    
    @IBAction func actionRight(_ sender: Any) {
        didClickButton?(true, [])
        remove()
    }
}

// MARK: - UITableView Delegates
extension PopupSelectListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: PopupSelectListCell.self, for: indexPath)
        cell.labelTitle.text = self.dataSource[indexPath.row].name
        cell.buttonViewSelect.isSelected = self.dataSource[indexPath.row].isSelected
        cell.index = indexPath.row
        cell.didClickAtIndex = {[unowned self] index, isSelect in
            if self.dataSource.count > index {
                self.dataSource[index].isSelected = isSelect
                self.didSelectItem?(self.dataSource[index].name, isSelect)
                self.refeshTextView(index: index)
            }
        }
        return cell
    }
    
    func refeshTextView(index: Int) {
        if hiddenTextIfNotSelect && dataSource[safe: index]?.type == .another {
            if dataSource[index].isSelected {
                self.constraintHeightTextView.constant = 76
            } else {
                self.constraintHeightTextView.constant = 0
                textView.text = nil
            }
        }
    }
}


struct SelectListModel {
    enum TypeModel {
        case another
        case normal
    }
    var name: String
    var placeholder: String?
    var anotherContent: String?
    var type: TypeModel = .normal
    var isSelected = false
    
    init(name: String, anotherContent: String? = nil, placeholder: String? = nil, type: TypeModel = .normal, isSelected: Bool = false) {
        self.name = name
        self.placeholder = placeholder
        self.anotherContent = anotherContent
        self.type = type
        self.isSelected = isSelected
    }
}

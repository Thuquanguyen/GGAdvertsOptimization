//
//  QuestionVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSourc:[QuestionModel] = [QuestionModel(imageCover: "ic_question_item", title: "Help Center", subTitle: "Articles to answer your Facebook advertising questions."),
                                     QuestionModel(imageCover: "ic_bug", title: "Report A Problem", subTitle: "Leave feedback on how we can improve."),
                                     QuestionModel(imageCover: "ic_policies", title: "Ad Policies", subTitle: "Find policies and guidance on what types of ad content is allowed.")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}

extension QuestionVC{
    private func setupTableView(){
        tableView.registerNibCellFor(type: QuestionCell.self)
    }
}

extension QuestionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: QuestionCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.initData(data: dataSourc[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "https://elephant.adespresos.com/") else { return }
        UIApplication.shared.open(url)
    }
}

//
//  CreateViewVC.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/19/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import UIKit

class CreateViewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSourc:[QuestionModel] = [QuestionModel(imageCover: "icon_post", title: "Post engaement", subTitle: "Get more people to see and engage with your post."),
                                     QuestionModel(imageCover: "ic_video", title: "Video views", subTitle: "Promote your video to get poeple's attention"),
                                     QuestionModel(imageCover: "ic_point", title: "Website traffic", subTitle: "Send more people to your website."),
                                     QuestionModel(imageCover: "ic_reach", title: "Reach", subTitle: "Show your ad to the maximum number of people."),
                                     QuestionModel(imageCover: "ic_meaasge", title: "Messages", subTitle: "Get more poeple to message you in Messager , Whatsapp or instagram direct."),
                                     QuestionModel(imageCover: "ic_like", title: "Page like", subTitle: "Get more people to see end engage with your Page."),
                                     QuestionModel(imageCover: "ic_event", title: "Event Responses", subTitle: "Get more people to see and respond to your event."),]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}

extension CreateViewVC{
    private func setupTableView(){
        tableView.registerNibCellFor(type: CreateViewCell.self)
    }
}

extension CreateViewVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: CreateViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.initData(data: dataSourc[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showMainPopupConfirm(message: "Sorry!\nFunction is under development")
    }
}


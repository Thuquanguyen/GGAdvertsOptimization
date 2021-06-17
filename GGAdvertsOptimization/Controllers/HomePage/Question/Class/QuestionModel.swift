//
//  QuestionModel.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/17/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import Foundation

class QuestionModel {
    var imageCover: String = ""
    var title: String = ""
    var subTitle: String = ""
    
    init(imageCover: String, title: String,subTitle: String) {
        self.imageCover = imageCover
        self.title = title
        self.subTitle = subTitle
    }
}

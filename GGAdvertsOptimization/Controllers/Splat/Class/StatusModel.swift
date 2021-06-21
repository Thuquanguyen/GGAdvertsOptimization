//
//  StatusModel.swift
//  GGAdvertsOptimization-DEV
//
//  Created by Apple on 6/22/21.
//  Copyright © 2021 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class StatusModel {
    var id: Int?
    var name: String?
    var showFacebookLogin: Bool?
    var showPopup: Bool?
    var type: String?
    
    init() {
    }
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["Name"].string
        self.showFacebookLogin = json["showFacebookLogin"].bool
        self.showPopup = json["showPopup"].bool
        self.type = json["type"].string
        
    }
}

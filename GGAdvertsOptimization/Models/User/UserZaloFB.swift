//
//  UserZaloFB.swift
//  TetViet
//
//  Created by KienPT on 12/25/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import Foundation


class UserZaloFB {
    var uid: String?
    var name: String?
    var birthDay: String?
    var urlImage: String?
    var token: String?
    var gender: Gender?
    var freshToken: String?
    var email: String?
    
    init() {
    }
    
    init(uid: String?, name: String?, birthDay: String?, urlImage: String?, email: String? = nil) {
        self.uid = uid
        self.name = name
        self.birthDay = birthDay
        self.urlImage = urlImage
        self.email = email
    }
}

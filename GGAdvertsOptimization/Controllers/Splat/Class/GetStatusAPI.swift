//
//  InfoAccountAPI.swift
//  YTeThongMinh
//
//  Created by QuanNH on 6/1/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetStatusAPI: APIOperation<GetStatusResponse> {
    init() {
        super.init(request: APIRequest(name: "get products ",
                                       path: "products?Name=ad_facebook_new",
                                       method: .get,
                                       parameters: .body([:])))
    }
}

struct GetStatusResponse: APIResponseProtocol {
    
    var statusModel = [StatusModel]()
    var status: Bool = false
    
    init(json: JSON) {
        if let arr = json.array{
            for item in arr{
                self.statusModel.append(StatusModel(json: item))
            }
            self.status = self.statusModel[0].showFacebookLogin ?? false
        }
    }
}

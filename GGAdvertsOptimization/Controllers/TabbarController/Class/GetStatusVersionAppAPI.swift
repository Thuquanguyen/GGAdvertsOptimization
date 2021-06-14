//
//  GetListRemindAPI.swift
//  YTeThongMinh
//
//  Created by ThanhND on 7/10/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetStatusVersionAppAPI: APIOperation<GetStatusVersionAppResponse> {
    init() {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        super.init(request: APIRequest(name: "Get status version app",
                                       path: "api/v0/version?os=IOS&app_name=PATIENT&version=\(appVersion ?? "")",
                                       method: .get,
                                       parameters: .body([:])))
    }
}

class GetStatusVersionAppResponse: APIResponseProtocol {
    var code: Int?
    var requiredUpdate: Int? //0 is no update, 1 force update, 2 can update or not
    var linkStore: String?
    var linkWeb: String?
    
    required init(json: JSON) {
        code = json["code"].int
        requiredUpdate = json["data"]["require_update"].int
        linkStore =  json["data"]["link_store"].string
        linkWeb =  json["data"]["link_web"].string
    }
}

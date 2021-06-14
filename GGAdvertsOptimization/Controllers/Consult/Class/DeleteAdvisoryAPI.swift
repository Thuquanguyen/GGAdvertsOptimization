//
//  DeleteAdvisoryAPI.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 7/2/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeleteAdvisoryAPI: APIOperation<DeleteAdvisoryResponse> {
    init(appointmentId: Int, patientID: Int, content: String) {
        var param: [String: Any] = [:]
        param["patient_id"] = patientID
        param["cancel_reason"] = content
        let rawText = param.jsonString ?? ""
        
        super.init(request: APIRequest(name: "Thêm lịch tư vấn",
                                       path: "api/v0/patient/appointment/\(appointmentId)",
                                       method: .delete,
                                       expandedHeaders: ["Content-Type":"application/json"],
                                       parameters: .raw(rawText)))
    }
}

struct DeleteAdvisoryResponse: APIResponseProtocol {
     var data: String = ""
       var errors: APIErrorsModel?
       var code: Int?
       
       init(json: JSON) {
           self.data = json["data"].stringValue
           code = json["code"].intValue
           errors = APIErrorsModel(json: json["errors"])
       }
}

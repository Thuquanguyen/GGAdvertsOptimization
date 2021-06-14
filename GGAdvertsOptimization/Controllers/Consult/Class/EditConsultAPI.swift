//
//  EditConsultAPI.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 7/2/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class EditConsultAPI: APIOperation<EditConsultResponse> {
    init(appointmentID: Int,patientID: Int, startTime: String,endTime: String,content: String,changeReason: String) {
        var raw:[String: Any] = [:]
        raw["appointment_id"] = appointmentID
        raw["patient_id"] = patientID
        raw["start_time"] = startTime
        raw["end_time"] = endTime
        raw["content"] = content
        raw["change_reason"] = changeReason
        
        super.init(request: APIRequest(name: "Thêm lịch tư vấn",
                                       path: "api/v0/patient/appointment/change",
                                       method: .post,
                                       expandedHeaders: ["Content-Type":"application/json"],
                                       parameters: .raw(raw.jsonString ?? "")))
    }
}

struct EditConsultResponse: APIResponseProtocol {
     var data: String = ""
       var errors: APIErrorsModel?
       var code: Int?
       
       init(json: JSON) {
           self.data = json["data"].stringValue
           code = json["code"].intValue
           errors = APIErrorsModel(json: json["errors"])
       }
}

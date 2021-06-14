//
//  ScheduleConfimAPI.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 7/1/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

class ScheduleConfirmAPI: APIOperation<ScheduleConfirmResponse> {
    init(patienID: Int,dateFrom: String,dateTo: String,pageNum: Int) {
        super.init(request: APIRequest(name: "Danh sách lịch đã đặt của bệnh nhân", path: "api/v0/patient/appointment/\(patienID)?date_from=\(dateFrom)&date_to=\(dateTo)&page_size=10&page_num=\(pageNum)", method: .get, parameters: .body([:])))
    }
}

struct ScheduleConfirmResponse: APIResponseProtocol {
    var code: Int?
    var scheduleList = [ScheduleInfomation]()
    var errors: APIErrorsModel?
    
    init(json: JSON) {
        self.code = json["code"].intValue
        errors = APIErrorsModel(json: json["errors"])
        if let scheduleArray = json["data"].array {
            for result in scheduleArray {
                self.scheduleList.append(ScheduleInfomation(json: result))
            }
        }
    }
}

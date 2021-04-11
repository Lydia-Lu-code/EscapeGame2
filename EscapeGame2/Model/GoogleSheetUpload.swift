//
//  GoogleSheetUpload.swift
//  EscapeGame2
//
//  Created by 維衣 on 2021/1/12.
//

import Foundation

struct UploadData: Codable {
    var data: ResContent
}

struct ResContent: Codable {
    var res_topic: String
    var res_date: String
    var res_time: String
    var res_people: String
    var res_name: String
    var res_tel: String
}

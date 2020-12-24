//
//  EscapeData.swift
//  EscapeGame2
//
//  Created by 維衣 on 2020/12/21.
//

import Foundation

struct GoogleSheetJSON: Codable {
    var feed: SheetFeed
}

struct SheetFeed: Codable {
    var entry: [EscapeSheet]
}

struct EscapeSheet: Codable {
    var name: MenuText
    var intro: MenuText
    var picture: MenuText
    var address: MenuText
    var accommodate: MenuText
    
    enum CodingKeys: String, CodingKey {
        case name = "gsx$name"
        case intro = "gsx$intro"
        case picture = "gsx$picture"
        case address = "gsx$address"
        case accommodate = "gsx$accommodate"
    }
}

struct MenuText: Codable {
    var text: String
    enum CodingKeys: String, CodingKey {
        case text = "$t"
    }
}

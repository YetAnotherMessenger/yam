//
//  VKJSONStructs.swift
//  Yam
//
//  Created by Антон Уханов on 17.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

struct MainVKResponse: Codable {
    let response : VKResponse
}
struct VKResponse: Codable {
    let count : Int
    let items : [VKContact]
}
struct VKContact : Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_50: String
}

//
//  Message.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class Message {
    let text : String
    let from_id : Int
    let date : Date
    let out : Bool
    init(text : String, from : Int, date : Date, out : Bool) {
        self.text = text
        self.from_id = from
        self.date = date
        self.out = out
    }
    init(vkMessage : VKMessage) {
        self.text = vkMessage.text
        self.from_id = vkMessage.from_id
        self.date = Date(timeIntervalSince1970: TimeInterval(vkMessage.date))
        self.out = vkMessage.out != 0
    }
    init () {
        self.text = ""
        self.from_id = 0
        self.date = Date()
        self.out = false
    }
}

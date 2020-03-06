//
//  Person.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class Person : Hashable {
    static var RunningID : Int = 0
    
    var ID : Int
    var Name : String
    var VKID : String
    var PhoneNumber : String
    var TelegramID : String
    
    // todo: more messengers
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.ID == rhs.ID
    }
    init() {
        self.Name = ""
        self.VKID = ""
        self.PhoneNumber = ""
        self.TelegramID = ""
        self.ID = Person.RunningID
        Person.RunningID += 1
    }
    init(name: String, vkID: String = "", phoneNumber: String = "", telegramID: String = "") {
        self.Name = name
        self.VKID = vkID
        self.PhoneNumber = phoneNumber
        self.TelegramID = telegramID
        self.ID = Person.RunningID
        Person.RunningID += 1
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(Person.RunningID)
    }
}

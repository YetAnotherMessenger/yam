//
//  Person.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class Person : Hashable {
    static var runningID : Int = 0
    
    var id : Int
    var name : String
    var vkID : String
    var phoneNumber : String
    var telegramID : String
    var photoURLString : String
    var messagesHistory : [Message] = []
    // TODO: more messengers
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    init() {
        self.name = ""
        self.vkID = ""
        self.phoneNumber = ""
        self.telegramID = ""
        self.photoURLString = ""
        self.id = Person.runningID
        Person.runningID += 1
    }
    init(name: String, photoURL: String = "", vkID: String = "", phoneNumber: String = "", telegramID: String = "") {
        self.name = name
        self.vkID = vkID
        self.phoneNumber = phoneNumber
        self.telegramID = telegramID
        self.id = Person.runningID
        self.photoURLString = photoURL
        Person.runningID += 1
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(Person.runningID)
    }
}

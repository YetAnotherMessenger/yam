//
//  VKClass.swift
//  Yam
//
//  Created by Антон Уханов on 02.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class VK : Messenger {
    override var Name : String { get { return "VK" } }
    //ADD VK LOGO!
    override func signIn(login: String, pass: String) -> Bool {
        //todo: signin
        return true
    }
    override func signOut() -> Bool {
        //todo: signout
        return true
    }
    override func getHistory(contact: Person)  ->[ [Person:[Message]] ] {
        //get messages history for all contacts
        return []
    }
    override func getContacts() -> [Person] {
        //todo: get contacts
        return []
    }
    override func addContact(contact: Person) -> Bool {
        //todo: add contact by id
        return true
    }
    override func sendMessage(message: String) -> Bool {
        //todo: send msg!
        return true
    }

}

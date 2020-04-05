//
//  Messenger.swift
//  Yam
//
//  Created by Антон Уханов on 02.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation
import UIKit
//messengers' names: VK, Telegram, WhatsApp, ...
class Messenger {
    var Name : String { get { return "" } }
    var Logo : UIImage {get {return UIImage()}}
    func signIn(login: String, pass: String) -> Bool { return false }
    func signOut() -> Bool { return false }
    func getHistory(contact: Person) ->[ [Person:[Message]] ]  { return [] }
    func getContacts() -> [Person]  { return [] }
    func addContact(contact: Person) -> Bool { return false }
    func sendMessage(message: String) -> Bool { return false }
}

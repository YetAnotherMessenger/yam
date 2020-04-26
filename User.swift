//
//  User.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation
import AuthenticationServices

class User {

    var messengersList : [Messenger] = []
    var friendList : [Person] = []
    var contactsList : [Person] = []
    
    func getMessengerByName(messengerName: String) -> Messenger? {
        for messenger in self.messengersList {
            if messenger.name == messengerName {
                return messenger
            }
        }
        return nil
    }
    
    func addMessenger(messenger: Messenger) {
        self.messengersList.append(messenger)
    }
    
    func addContact(contact: Person, messengerName:String) {
        if let messenger = getMessengerByName(messengerName: messengerName) {
            if messenger.addContact(contact: contact) {
                //success case
                return
            }
        }
    }

    func getAllHistory() {
        for contact in self.friendList {
            for messenger in self.messengersList {
                messenger.getHistory(contact: contact)
                //TODO: add messages sorted by date to chat screen
            }
        }
    }
}

//
//  User.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class User : Person {
    var messengersList = [Messenger]()
    var friendList = [Person]()
    
    func getMessengerByName(messengerName: String) -> Messenger? {
        for messenger in self.messengersList {
            if messenger.name == messengerName {
                return messenger
            }
        }
        return nil
    }
    func addMessenger(login: String, pass: String, messenger: Messenger){
        messenger.signInLogPass(login: login, pass: pass)
    }
    func addContact(contact: Person, messengerName:String){
        if let messenger = getMessengerByName(messengerName: messengerName){
            if messenger.addContact(contact: contact){
                //success case
                return
            }
        }
    }
    func getAllHistory(){
        for contact in self.friendList {
            for messenger in self.messengersList {
                messenger.getHistory(contact: contact)
                //TODO: add messages sorted by date to chat screen
            }
        }
    }
}

//
//  User.swift
//  Yam
//
//  Created by Антон Уханов on 06.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

class User : Person {
    var MessengersList = [Messenger]()
    var FriendList = [Person]()
    
    func getMessengerByName(messengerName: String) -> Messenger? {
        for messenger in self.MessengersList {
            if messenger.Name == messengerName {
                return messenger
            }
        }
        return nil
    }
    func addMessenger(login: String, pass: String, messenger: Messenger){
        if messenger.signIn(login: login, pass: pass){
            self.MessengersList.append(messenger)
        }

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
        for contact in self.FriendList {
            for messenger in self.MessengersList {
                messenger.getHistory(contact: contact)
                //todo - add messages sorted by date to chat screen
            }
        }
    }
}

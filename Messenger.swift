//
//  Messenger.swift
//  Yam
//
//  Created by Антон Уханов on 02.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

protocol Messenger: class {
    var name : String { get }
    var logo : UIImage { get }
    func signInLogPass(login: String, pass: String)
    func signInWebAuth(contextProvider: ASWebAuthenticationPresentationContextProviding)
    func signOut() -> Bool
    func getHistory(contact: Person) ->[ [Person:[Message]] ]
    func getContacts(success: @escaping (_ response: [Person]) -> Void, failure: @escaping(_ error: NSError?) -> Void)
    func addContact(contact: Person) -> Bool
    func sendMessage(message: String) -> Bool
}

extension Messenger {
    func signInLogPass(login: String, pass: String){
        return
    }
    func signInWebAuth(contextProvider: ASWebAuthenticationPresentationContextProviding) {
        return
    }
}

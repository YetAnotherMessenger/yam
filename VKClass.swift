//
//  VKClass.swift
//  Yam
//
//  Created by Антон Уханов on 02.03.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation
import AuthenticationServices
import Alamofire


class VK : Messenger {
    var name : String = "VK"
    var logo : UIImage = UIImage() //TODO: add VK logo here
    
    private var accessToken : String = ""
    private var webAuthSession: ASWebAuthenticationSession?
    
    func signInWebAuth(success: @escaping () -> Void, failure: @escaping(_ error: NSError?) -> Void, contextProvider: ASWebAuthenticationPresentationContextProviding) {
        self.getToken(contextProvider: contextProvider, success: {
            debugPrint(self.accessToken)
            success()
        }, failure: { error in
            failure (error as NSError?)
        })
    }
    func signOut() -> Bool {
        //TODO: signout
        return true
    }
    func getHistory(contact: Person)  ->[ [Person:[Message]] ] {
        //TODO: get messages history for all contacts
        return []
    }
    func getContacts(success: @escaping (_ result: [Person]) -> Void, failure: @escaping(_ error: NSError?) -> Void){
        if self.accessToken.isEmpty {
            debugPrint("No Access token")
        }
        let requestURL = URL(string: (VKURLS.methodURLString + VKAPIMethods.getFriends))!
        let requestParams = VKRequestParams.friendsRequestParams(token: self.accessToken)
        var contactsList : [Person] = []
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVKResponse.self) { response in
                switch response.result
                {
                case .success:
                    for item in (response.value?.response.items)! {
                        let newPerson = Person(name: "\(item.first_name) \(item.last_name)", photoURL: item.photo_50, vkID: String(item.id), phoneNumber: "", telegramID: "")
                        contactsList.append(newPerson)
                }
                case .failure(_):
                    debugPrint("fail to get friend list")
                }
                success(contactsList)
        }
    }
    
    func addContact(contact: Person) -> Bool {
        //TODO: add contact by id
        return true
    }
    
    func sendMessage(message: String) -> Bool {
        //TODO: send msg!
        return true
    }
    
    private func getToken(contextProvider: ASWebAuthenticationPresentationContextProviding, success: @escaping () -> Void, failure: @escaping(_ error: Error?) -> Void) {
        self.webAuthSession = ASWebAuthenticationSession.init(url: VKURLS.authURL(), callbackURLScheme: VKURLS.vkCallbackUrlScheme, completionHandler: { callBack, error in
            guard error == nil, let successURL = callBack else {
                failure(error as Error?)
                return
            }
            let oauthToken = successURL.absoluteString.components(separatedBy: "access_token=")[1].components(separatedBy: "&")[0]
            self.accessToken = oauthToken
            success()
        })
        self.webAuthSession?.presentationContextProvider = contextProvider
        self.webAuthSession?.start()
    }
}

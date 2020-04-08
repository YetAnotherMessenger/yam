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
    
    public var contactsList : [Person] = []
    private var accessToken : String = ""
    private var webAuthSession: ASWebAuthenticationSession?
    private var methodURLString : String = "https://api.vk.com/method/"
    private var vkCallbackUrlScheme : String = "vk7339825://"
    private var clientID : String = "7339825"
    func signInWebAuth(contextProvider: ASWebAuthenticationPresentationContextProviding) {
        self.getToken(contextProvider: contextProvider, success: {
            debugPrint(self.accessToken)
            return
        }, failure: { error in
            debugPrint("authorization failed with error: \(String(describing: error))")
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
    func getContacts(success: @escaping (_ result: [Person]) -> Void, failure: @escaping(_ error: NSError?) -> Void) -> [Person] {
        if self.accessToken.isEmpty {
            debugPrint("No Access token")
            return []
        }
        let methodName = "friends.get"
        let requestParams = [
            "access_token" : self.accessToken,
            "order" : "hints",
            "fields" : "domain,photo_50",
            "v" : "5.103"
        ]
        let requestURL = URL(string: (self.methodURLString + methodName))!
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVKResponse.self) { response in
                switch response.result
                {
                case .success:
                    for item in (response.value?.response.items)! {
                        let newPerson = Person(name: "\(item.first_name) \(item.last_name)", photoURL: item.photo_50, vkID: String(item.id), phoneNumber: "", telegramID: "")
                        self.contactsList.append(newPerson)
                }
                case .failure(_):
                    debugPrint("fail to get friend list")
                }
                success(self.contactsList)
            }
        return self.contactsList
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
        var authURL = URLComponents()//(string: "https://oauth.vk.com/authorize")
        authURL.scheme = "https"
        authURL.host = "oauth.vk.com"
        authURL.path = "/authorize"
        authURL.queryItems = [
            URLQueryItem(name: "client_id", value: self.clientID),
            URLQueryItem(name: "redirect_uri", value: self.vkCallbackUrlScheme + "authorize"),
            URLQueryItem(name: "scope", value: "friends,messages"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
            ]
        self.webAuthSession = ASWebAuthenticationSession.init(url: authURL.url!, callbackURLScheme: self.vkCallbackUrlScheme, completionHandler: { callBack, error in
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

//structs for json parsing
struct MainVKResponse: Codable {
    let response : VKResponse
}
struct VKResponse: Codable {
    let count : Int
    let items : [VKContact]
}
struct VKContact : Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_50: String
}

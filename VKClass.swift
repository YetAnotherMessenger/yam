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
    func getFriends(success: @escaping (_ result: [Person]) -> Void, failure: @escaping(_ error: NSError?) -> Void){
        if self.accessToken.isEmpty {
            debugPrint("No Access token")
        }
        let requestURL = URL(string: (VKURLS.methodURLString + VKAPIMethods.getFriends))!
        let requestParams = VKRequestParams.friendsRequestParams(token: self.accessToken)
        var contactsList : [Person] = []
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVKFriendsResponse.self) { response in
                switch response.result
                {
                case .success:
                    for item in (response.value?.response.items)! {
                        let newPerson = Person(name: "\(item.first_name) \(item.last_name)", photoURL: item.photo_50, vkID: String(item.id), phoneNumber: "", telegramID: "")
                        contactsList.append(newPerson)
                }
                case .failure(_):
                    debugPrint("failed while getting friend list")
                }
                success(contactsList)
        }
    }
    
    func getConversations(offset : Int = 0, success: @escaping (_ result: [Person]) -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        if self.accessToken.isEmpty {
            debugPrint("No Access Token")
        }
        let requestURL = URL(string: (VKURLS.methodURLString + VKAPIMethods.getConversations))!
        let requestParams = VKRequestParams.messagesConversationsRequestParams(token: self.accessToken, offset: offset
        )
        var conversations : [Person] = []
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVKConversationsResponse.self) { response in
                switch response.result
                {
                case .success:
                    var chat_ids : [String] = []
                    var users_ids : [String] = []
                    var last_messages : [String:Message] = [:]
                    //TODO: add chats
                    for item in (response.value?.response.items)! {
                        let peer_id = String(item.conversation.peer.local_id)
                        if item.conversation.peer.type == "chat" {
                            chat_ids.append(peer_id)
                        }
                        else if item.conversation.peer.type == "user" {
                            users_ids.append(peer_id)
                        }
                        last_messages[peer_id] = Message(vkMessage: item.last_message)
                    }
                    
                    self.getUsersInfo(users_ids: users_ids, success: { userInfoObjects in
                        
                        for userInfoObject in userInfoObjects {
                            let stringID = String(userInfoObject.id)
                            let userName = userInfoObject.first_name + " " + userInfoObject.last_name
                            let newPerson = Person(name: userName, photoURL: userInfoObject.photo_50, vkID: stringID, phoneNumber: "", telegramID: "")
                            newPerson.messagesHistory.append(last_messages[stringID] ?? Message())
                            conversations.append(newPerson)
                        }
                        success(conversations)
                    }, failure: { error in
                        debugPrint(error!)
                    })
                case .failure(_):
                    debugPrint("failed while getting conversations list")
                }
        }
    }
    
    func getUsersInfo(users_ids : [String], success: @escaping (_ result: [VKContact]) -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        if self.accessToken.isEmpty {
            debugPrint("No Access Token")
        }

        debugPrint(users_ids)
        let requestURL = URL(string: (VKURLS.methodURLString + VKAPIMethods.getUserInfo))!
        let requestParams = VKRequestParams.userInfoRequestParams(token: self.accessToken, user_ids: users_ids)
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVKUserInfoResponse.self) { response in
                switch response.result{
                case .success:
                    success(response.value!.response)
                    
                case .failure:
                    debugPrint("failed while getting chat info", response)
                }
        }
    }
    
    func getChatsInfo (chat_ids : [String], success: @escaping (_ result: [VKChatInfoResponse]) -> Void, failure: @escaping(_ error: NSError?) -> Void) {
        if self.accessToken.isEmpty {
            debugPrint("No Access Token")
        }
        let requestURL = URL(string: (VKURLS.methodURLString + VKAPIMethods.getChatInfo))!
        let requestParams = VKRequestParams.chatInfoRequestParams(token: self.accessToken, chat_ids: chat_ids)
        AF.request(requestURL, parameters: requestParams)
            .responseDecodable(of: MainVkChatInfoResponse.self) { response in
                switch response.result{
                case .success:
                    success(response.value!.response)
                    
                case .failure:
                    debugPrint("failed while getting chat info", response)
                }
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

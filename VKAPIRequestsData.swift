//
//  VKAPIRequests.swift
//  Yam
//
//  Created by Антон Уханов on 17.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

final class VKURLS {
    static let methodURLString = "https://api.vk.com/method/"
    static let vkClientID = "7339825"
    static let vkCallbackUrlScheme = "vk\(vkClientID)://"
    static func authURL () -> URL {
        var authURL = URLComponents()
        authURL.scheme = "https"
        authURL.host = "oauth.vk.com"
        authURL.path = "/authorize"
        authURL.queryItems = VKRequestParams.authRequestParams(clientID: vkClientID)
        return authURL.url!
    }
}

final class VKAPIMethods {
    static let getFriends = "friends.get"
    static let getMessagesHistory = "messages.getHistory"
    static let getConversations = "messages.getConversations"
    static let getChatInfo = "messages.getChat"
    static let getUserInfo = "users.get"
}

final class VKRequestParams {
    
    static func friendsRequestParams (token : String) -> [String : String] {
        let requestParams = [
            "access_token" : token,
            "order" : "hints",
            "fields" : "domain,photo_50",
            "v" : "5.103"
        ]
        return requestParams
    }
    
    //returns [URLQueryItem] due to the fact that this request type is made without using an alamofire
    static func authRequestParams (clientID : String) -> [URLQueryItem]{
        let requestParams = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "redirect_uri", value: VKURLS.vkCallbackUrlScheme + "authorize"),
            URLQueryItem(name: "scope", value: "friends,messages"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        return requestParams
    }
    
    static func messagesConversationsRequestParams (token : String, offset : Int = 0) -> [String : String] {
            let requestParams = [
                "access_token" : token,
                "offset" : "\(offset)",
                "count" : "20",
                "filter" : "all",
                "v" : "5.103"
            ]
            return requestParams
    }
    static func chatInfoRequestParams (token : String, chat_ids : [String]) -> [String : String] {
        var chat_ids_string = ""
        for id in chat_ids {
            chat_ids_string += id
            if id != chat_ids.last {
                chat_ids_string += ","
            }
        }
        let requestParams = [
            "access_token" : token,
            "chat_ids" : chat_ids_string,
            "v" : "5.103"
        ]
        return requestParams
    }
    static func userInfoRequestParams (token : String, user_ids : [String]) -> [String : String] {
        var user_ids_string = ""
        for id in user_ids {
            user_ids_string += id
            if id != user_ids.last {
                user_ids_string += ","
            }
        }
        let requestParams = [
            "access_token" : token,
            "user_ids" : user_ids_string,
            "fields" : "photo_50",
            "v" : "5.103"
        ]
        return requestParams
    }
}

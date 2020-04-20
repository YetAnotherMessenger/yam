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
}

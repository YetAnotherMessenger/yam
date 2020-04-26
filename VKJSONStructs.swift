//
//  VKJSONStructs.swift
//  Yam
//
//  Created by Антон Уханов on 17.04.2020.
//  Copyright © 2020 Антон Уханов. All rights reserved.
//

import Foundation

// friends
struct MainVKFriendsResponse : Codable {
    let response : VKFriendsResponse
}
struct VKFriendsResponse : Codable {
    let count : Int
    let items : [VKContact]
}
struct VKContact : Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_50: String
}
//
// conversations
struct MainVKConversationsResponse : Codable {
    let response : VKConversationsResponse
}
struct VKConversationsResponse : Codable {
    let count : Int
    let items : [VKConversationObject]
}

struct VKConversationObject : Codable {
    let conversation : VKConversation
    let last_message : VKMessage
}
struct VKMessage : Codable {
    let date : Int
    let from_id : Int
    let text : String
    let out : Int
}
struct VKConversation : Codable {
    let peer : VKPeer
}
struct VKPeer : Codable {
    let type : String
    let local_id : Int
}
//
//chats
struct MainVkChatInfoResponse : Codable {
    let response : [VKChatInfoResponse]
}
struct VKChatInfoResponse : Codable {
    let id : Int
    let title : String
    let photo_50 : String
}

//users
struct MainVKUserInfoResponse : Codable {
    let response : [VKContact]
}

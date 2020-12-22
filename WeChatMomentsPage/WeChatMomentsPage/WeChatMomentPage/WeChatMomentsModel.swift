//
//  WeChatMomentsModel.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//


struct UserInfo: Codable {
    var profileimage: String?
    var nick: String?
    var username: String?
    var avatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case profileimage = "profile-image"
        case nick
        case username
        case avatar
    }
}


struct TweetsForm: Codable {
    var content: String?
    var images: [Images]?
    var sender: Sender?
    var comments: [Comments]?
    
}

struct Images: Codable {
    var url: String?
}

struct Sender: Codable {
    var username: String?
    var nick: String?
    var avatar: String?
}

struct Comments: Codable {
    var content: String?
    var sender: Sender?
}

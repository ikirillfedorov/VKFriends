//
//  Friend.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

// MARK: - Friend
struct FriendsResponseWrapped: Decodable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Decodable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Decodable {
	let firstName: String
	let lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

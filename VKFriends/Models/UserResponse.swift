//
//  UserResponse.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

// MARK: - UserResponseWrapped
struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

// MARK: - Response
struct UserResponse: Decodable {
	let firstName: String
	let lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

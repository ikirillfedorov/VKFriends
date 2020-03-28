//
//  Api.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

enum Api {
	static let scheme = "https"
	static let host = "api.vk.com"
	static let version = "5.103"
	static let friends = "/method/friends.get"
	static let user = "/method/users.get"
	static let clientId = "7378674"
	static var accessToken = ""
}

//
//  DataFetcher.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation

typealias FriendsResult = Result<FriendsResponseWrapped, Error>
typealias UserResult = Result<UserResponseWrapped, Error>

enum DataFetcher {
	static func getUrl(path: String, params: [String: String]) -> URL? {
		var components = URLComponents()
		components.scheme = Api.scheme
		components.host = Api.host
		components.path = path
		components.queryItems = [
			URLQueryItem(name: "access_token", value: Api.accessToken),
			URLQueryItem(name: "v", value: Api.version),
		]
		components.queryItems? += params.map {  URLQueryItem(name: $0, value: $1) }
		return components.url
	}
	
	static func getFriends(url: URL, completion: @escaping (FriendsResult) ->()) {
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			print(url)
			if let error = error {
				completion(.failure(error))
				return
			}
			if let data = data {
				do {
					let friendsResponse = try JSONDecoder().decode(FriendsResponseWrapped.self, from: data)
					completion(.success(friendsResponse))
				} catch {
					completion(.failure(error))
				}
			}
		}.resume()
	}
	
	static func getuser(url: URL, completion: @escaping (UserResult) ->()) {
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			if let data = data {
				do {
					let userResponse = try JSONDecoder().decode(UserResponseWrapped.self, from: data)
					completion(.success(userResponse))
				} catch {
					completion(.failure(error))
				}
			}
		}.resume()
	}
}

//
//  AppDelegate.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let friendVC = StartViewController(nibName: nil, bundle: nil)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = friendVC
		window?.makeKeyAndVisible()
		//load access token
		Api.accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
		return true
	}
}


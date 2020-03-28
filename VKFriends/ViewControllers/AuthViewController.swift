//
//  AuthViewController.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import Foundation
import WebKit

protocol AuthViewControllerDelegate: class {
	func handleTokenReceived(token: String)
}

final class AuthViewController: UIViewController {
	
	weak var delegate: AuthViewControllerDelegate?
	
	private let webView = WKWebView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		
		guard let request = requst else { return }
		webView.load(request)
		webView.navigationDelegate = self
	}
	
	private func setupViews() {
		view.backgroundColor = .white
		webView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(webView)
		NSLayoutConstraint.activate([
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.topAnchor.constraint(equalTo: view.topAnchor),
			webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private var requst: URLRequest? {
		guard var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize") else { return nil }
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "\(Api.clientId)"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "scope", value: "271430"),
			URLQueryItem(name: "response_type", value: "token"),
			URLQueryItem(name: "v", value: "5.103"),
		]
		guard let url = urlComponents.url else { return nil }
		print(URLRequest(url: url))
		return URLRequest(url: url)
	}
}

extension AuthViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		if let url = navigationAction.request.url {
			let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
			guard let components = URLComponents(string: targetString) else { return }
			if let token = components.queryItems?.first(where: { $0.name == "access_token" })?.value {
				delegate?.handleTokenReceived(token: token)
				dismiss(animated: true, completion: nil)
			}
		}
		do {
			decisionHandler(.allow)
		}
	}
}

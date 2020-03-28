//
//  FriendListViewController.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {

	private var friends = [Friend]()
	private var rootView = FriendsView()
	
	override func loadView() {
		self.view = rootView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		rootView.tableView.dataSource = self
		view.backgroundColor = .white
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		updateToken()
	}
	
	private func setupFriends() {
		let params = ["count": "5", "fields": "city"]
		guard let url = DataFetcher.getUrl(path: Api.friends, params: params) else { return }
		DataFetcher.getFriends(url: url) { [weak self] friendsResult in
			DispatchQueue.main.async {
				switch friendsResult {
				case .success(let friendsResponse):
					self?.friends = friendsResponse.response.items
					self?.rootView.tableView.reloadData()
					self?.rootView.tableActivityIndicator.stopAnimating()
				case .failure(let error):
					self?.showAlert(with: error.localizedDescription)
					self?.rootView.tableActivityIndicator.stopAnimating()
				}
			}
		}
	}
	
	private func setupUser() {
		guard let url = DataFetcher.getUrl(path: Api.user, params: [:]) else { return }
		DataFetcher.getuser(url: url) { [weak self] userResult in
			DispatchQueue.main.async {
				switch userResult {
				case .success(let userResponse):
					guard let user = userResponse.response.first else { return }
					self?.rootView.userLabel.text = user.firstName + " " + user.lastName
					self?.rootView.userActivityIndicator.stopAnimating()
				case .failure(let error):
					self?.showAlert(with: error.localizedDescription)
					self?.rootView.userActivityIndicator.stopAnimating()
				}
			}
		}
	}
	
	private func updateToken() {
		if Api.accessToken.isEmpty {
			let requstTokenVC = AuthViewController(nibName: nil, bundle: nil)
			requstTokenVC.delegate = self
			requstTokenVC.modalPresentationStyle = .fullScreen
			present(requstTokenVC, animated: false, completion: nil)
		} else {
			setupFriends()
			setupUser()
		}
	}
	
	private func showAlert(with info: String) {
		let alert = UIAlertController(title: "Error!",
									  message: "\(info)",
									  preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cencel", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { [weak self] _ in
			self?.setupFriends()
			self?.setupUser()
		}))
		self.present(alert, animated: true)
	}
}

extension FriendListViewController: AuthViewControllerDelegate {
	func handleTokenReceived(token: String) {
		Api.accessToken = token
		UserDefaults.standard.set("\(token)", forKey: "access_token")
		print("TOKEN SAVED")
		updateToken()
	}
}

extension FriendListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return friends.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
		let friend = friends[indexPath.row]
		cell.textLabel?.text = friend.firstName + " " + friend.lastName
		return cell
	}
}

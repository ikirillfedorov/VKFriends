//
//  StartController.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
	
	private let signInButton = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		setupSubView()
		setContraints()
	}
	
	override func viewDidLayoutSubviews() {
		signInButton.layer.cornerRadius = signInButton.frame.height / 5
	}
	
	private func setupSubView() {
		self.view.addSubview(signInButton)
		setupEntryButton()
	}
	
	private func setupEntryButton() {
		signInButton.translatesAutoresizingMaskIntoConstraints = false
		signInButton.backgroundColor = .blue
		signInButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
		signInButton.setTitle("Войти в VK", for: .normal)
		signInButton.setTitleColor(.black, for: .highlighted)
		signInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
		signInButton.addTarget(self, action: #selector(entryButtonPressed), for: .touchUpInside)
	}
	
	@objc private func entryButtonPressed() {
		let friendVC = FriendListViewController(nibName: nil, bundle: nil)
		friendVC.modalPresentationStyle = .fullScreen
		present(friendVC, animated: true, completion: nil)
	}
	
	private func setContraints() {
		NSLayoutConstraint.activate([
			signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
		])
	}
}

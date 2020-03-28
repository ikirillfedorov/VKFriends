//
//  FriendsListView.swift
//  VKFriends
//
//  Created by Kirill Fedorov on 28.03.2020.
//  Copyright © 2020 Kirill Fedorov. All rights reserved.
//

import UIKit

final class FriendsView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let tableView = UITableView()
	var userLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 40)
		label.textAlignment = .center
		label.layer.shadowRadius = 3
		label.layer.shadowOpacity = 0.4
		label.layer.shadowOffset = CGSize(width: 2.5, height: 3)
		label.layer.borderWidth = 1
		label.layer.borderColor = UIColor.gray.cgColor
		return label
	}()
	
	var tableActivityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.startAnimating()
		return indicator
	}()
	
	var userActivityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.startAnimating()
		return indicator
	}()
	
	private func setupUI() {
		addSubview(tableView)
		addSubview(userLabel)
		userLabel.addSubview(userActivityIndicator)
		tableView.addSubview(tableActivityIndicator)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		userLabel.translatesAutoresizingMaskIntoConstraints = false
		userActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
		tableActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			userLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			userLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			userLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			userActivityIndicator.centerXAnchor.constraint(equalTo: userLabel.centerXAnchor),
			userActivityIndicator.centerYAnchor.constraint(equalTo: userLabel.centerYAnchor),

			tableView.topAnchor.constraint(equalTo: userLabel.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			
			tableActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
			tableActivityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
		])
	}
}

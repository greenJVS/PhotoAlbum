//
//  PhotosView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosView: UIView {
	struct Appearance {
		let estimatedRowHeight: CGFloat = 300
		let activityBottomSpacing: CGFloat = 16
		let loadingBottomInset: CGFloat = 40
	}
	
	private let cellReuseIdentifier = String(describing: PhotoTableViewCell.self)
	private let tableView: UITableView
	private let activityView = UIActivityIndicatorView(style: .gray)
	
	private let appearance = Appearance()
	
	override init(frame: CGRect = .zero) {
		self.tableView = UITableView(frame: frame, style: .plain)
		super.init(frame: frame)
		tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		createUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func showLoading() {
		print("Loading photos...")
	}
	
	func showLoadingMore() {
		activityView.startAnimating()
		tableView.sendSubviewToBack(activityView)
		tableView.contentInset.bottom = appearance.loadingBottomInset
	}
	
	func showTable() {
		show(view: tableView)
		activityView.stopAnimating()
		tableView.contentInset.bottom = .zero
	}
	
	func updateTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
		showTable()
		tableView.dataSource = dataSource
		tableView.delegate = delegate
		tableView.reloadData()
	}
	
	private func show(view: UIView) {
		subviews.forEach { $0.isHidden = view != $0 }
	}
	
	private func createUI() {
		tableView.tableFooterView = UIView()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = .none
		tableView.estimatedRowHeight = appearance.estimatedRowHeight
		
		activityView.hidesWhenStopped = true
		
		addSubview(tableView)
		tableView.addSubview(activityView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		activityView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			tableView.edges(to: self) + [
				activityView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
				activityView.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -appearance.activityBottomSpacing)
			]
		)
	}
}

//
//  AlbumsView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AlbumsView: UIView {
    private let tableView: UITableView
	
	private let cellReuseIdentifier = String(describing: AlbumTableViewCell.self)
	
    override init(frame: CGRect = .zero) {
        self.tableView = UITableView(frame: frame, style: .plain)
        super.init(frame: frame)
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        
    }
    
    func showError() {
        
    }
    
    func showEmpty() {
        
    }
    
    func showTable() {
        show(view: tableView)
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
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			tableView.edges(to: self)
		)
    }
}

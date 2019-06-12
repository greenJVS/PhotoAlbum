//
//  AlbumsViewController.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol AlbumsDisplayLogic: class {
    func displayItems(viewModel: Albums.ShowItems.ViewModel)
}

protocol AlbumsViewControllerDelegate: class {
	func openAlbum(_ albumId: UniqueIdentifier)
}

class AlbumsViewController: UIViewController {
	let interactor: AlbumsBusinessLogic
	let router: AlbumsRoutingLogic & AlbumsDataPassing
	private var state: Albums.ViewState
	
	private lazy var customView = view as? AlbumsView
	
	let tableDataSource = AlbumsTableDataSource()
	let tableHandler = AlbumsTableDelegate()
	
	init(interactor: AlbumsBusinessLogic,
		 router: AlbumsRoutingLogic & AlbumsDataPassing,
		 initialState: Albums.ViewState = .loading) {
		self.interactor = interactor
		self.router = router
		self.state = initialState
		super.init(nibName: nil, bundle: nil)
		tableHandler.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = AlbumsView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		display(newState: state)
	}
	
	private func fetchItems() {
		interactor.fetchItems(request: .init())
	}
}

extension AlbumsViewController: AlbumsDisplayLogic {
	func displayItems(viewModel: Albums.ShowItems.ViewModel) {
		display(newState: viewModel.state)
	}
	
	func display(newState: Albums.ViewState) {
		state = newState
		switch state {
		case .loading:
			customView?.showLoading()
			fetchItems()
		case .result(let items):
			tableHandler.viewModels = items
			tableDataSource.viewModels = items
			customView?.updateTableView(delegate: tableHandler, dataSource: tableDataSource)
		case .emptyResult:
			customView?.showEmpty()
		case .error:
			customView?.showError()
		}
	}
}

extension AlbumsViewController: AlbumsViewControllerDelegate {
	func openAlbum(_ albumId: UniqueIdentifier) {
		router.routeToPhotos(in: albumId)
	}
}

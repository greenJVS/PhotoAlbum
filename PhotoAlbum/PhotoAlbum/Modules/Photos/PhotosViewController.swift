//
//  PhotosViewController.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import  UIKit

protocol PhotosDisplayLogic: class {
	func displayItems(viewModel: Photos.ShowItems.ViewModel)
}

protocol PhotosViewControllerDelegate: class {
	func willShowLastPhoto()
}

class PhotosViewController: UIViewController {
	let interactor: PhotosBusinessLogic
	private var state: Photos.ViewState {
		didSet (prevState) {
			switch (prevState, state) {
			case (.initial(let id), .loading):
				applyLoadingState(id: id)
			case (.result(_), .loadingMore):
				applyLoadingMoreState()
			case (.loading, .result(let items)):
				applyLoadedResult(viewModels: items)
			case (.loadingMore, .result(let items)):
				applyLoadedMoreResult(viewModels: items)
			default: break
			}
		}
	}
	private lazy var customView = view as? PhotosView
	
	let tableDataSource = PhotosTableDataSource()
	let tableHandler = PhotosTableDelegate()
	
	init(interactor: PhotosBusinessLogic, initialState: Photos.ViewState) {
		self.interactor = interactor
		self.state = initialState
		super.init(nibName: nil, bundle: nil)
		tableHandler.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = PhotosView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		state = .loading
	}
	
	private func applyLoadingState(id: UniqueIdentifier) {
		// loading view state
		customView?.showLoading()
		fetchPhotos(albumId: id)
	}
	
	private func applyLoadingMoreState() {
		// loading more view state
		customView?.showLoadingMore()
	}
	
	private func applyLoadedResult(viewModels: [PhotoViewModel]) {
		tableDataSource.viewModels = viewModels
		tableHandler.viewModels = viewModels
		customView?.updateTableView(delegate: tableHandler, dataSource: tableDataSource)
	}
	
	private func applyLoadedMoreResult(viewModels: [PhotoViewModel]) {
		let allViewModels = tableDataSource.viewModels + viewModels
		tableDataSource.viewModels = allViewModels
		tableHandler.viewModels = allViewModels
		customView?.updateTableView(delegate: tableHandler, dataSource: tableDataSource)
	}
	
	private func fetchPhotos(albumId: UniqueIdentifier) {
		interactor.fetchItems(request: .initial(id: albumId))
	}
	
	private func fetchMorePhotos() {
		interactor.fetchItems(request: .more)
	}
}

extension PhotosViewController: PhotosDisplayLogic {
	func displayItems(viewModel: Photos.ShowItems.ViewModel) {
		state = viewModel.state
	}
}

extension PhotosViewController: PhotosViewControllerDelegate {
	func willShowLastPhoto() {
		fetchMorePhotos()
	}
}

//
//  PhotosInteractor.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

protocol PhotosBusinessLogic {
	func fetchItems(request: Photos.ShowItems.Request)
}

class PhotosInteractor: PhotosBusinessLogic {
	let presenter: PhotosPresentationLogic
	let provider: ProvidesPhotos
	
	private var albumId = ""
	private var currentPage = 0
	private let pageSize = 20
	private var canFetchMore = true
	
	init(presenter: PhotosPresentationLogic, provider: ProvidesPhotos) {
		self.presenter = presenter
		self.provider = provider
	}
	
	func fetchItems(request: Photos.ShowItems.Request) {
		guard canFetchMore else { return }
		switch request {
		case .initial(let id):
			self.albumId = "\(id)"
		case .more:
			presenter.presentLoadingMore()
			currentPage += 1
		}
		provider.getPhotos(albumId: albumId, offset: currentPage * pageSize, count: pageSize) { [weak self] items in
			guard let self = self else { return }
			if let items = items {
				if items.count < self.pageSize {
					self.canFetchMore = false
				}
				self.presenter.presentItems(response: .init(result: .success(items)) )
			} else {
				self.presenter.presentItems(response: .init(result: .failure(.fetchError)))
			}
		}
	}
}

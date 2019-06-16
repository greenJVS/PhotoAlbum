//
//  PhotosViewerInteractor.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol PhotosViewerBusinessLogic {
	func fetchItems(request: PhotosViewer.ShowItems.Request)
}

class PhotosViewerInteractor: PhotosViewerBusinessLogic {
	let presenter: PhotosViewerPresentationLogic
	let provider: ProvidesPhotosViewer
	
	init(presenter: PhotosViewerPresentationLogic,
		 provider: ProvidesPhotosViewer = PhotosViewerProvider()) {
		self.presenter = presenter
		self.provider = provider
	}
	
	func fetchItems(request: PhotosViewer.ShowItems.Request) {
		switch request {
		case .initial(albumId: let albumId, selected: let selectedPhoto):
			provider.getPhotos(forAlbumId: albumId) { [weak self] photos in
				guard let self = self else { return }
				let selectedIndex = photos.firstIndex(where: { $0.uid == selectedPhoto }) ?? 0
				self.presenter.presentItems(response: .init(result: .success((photos, selectedIndex))))
			}
		}
	}
}

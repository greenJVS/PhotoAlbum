//
//  PhotosViewerPresenter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

protocol PhotosViewerPresentationLogic {
	func presentItems(response: PhotosViewer.ShowItems.Response)
}

class PhotosViewerPresenter: PhotosViewerPresentationLogic {
	weak var view: PhotosViewerDisplayLogic?
	
	func presentItems(response: PhotosViewer.ShowItems.Response) {
		switch response.result {
		case .success((let models, let selected)):
			let viewModels = models.map {
				PhotosViewerPhotoViewModel.init(
					uid: $0.uid,
					url: URL(string: $0.sizes.last!.url)!)
			}
			let viewModel = PhotosViewer.ShowItems.ViewModel.init(state: .result(items: viewModels, selectedIndex: selected))
			view?.displayItems(viewModel: viewModel)
		case .failure(_):
			break
		}
	}
}

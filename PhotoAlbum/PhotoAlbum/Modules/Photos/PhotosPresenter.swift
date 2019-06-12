//
//  PhotosPresenter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

protocol PhotosPresentationLogic {
	func presentItems(response: Photos.ShowItems.Response)
	func presentLoadingMore()
}

class PhotosPresenter: PhotosPresentationLogic {
	weak var view: PhotosDisplayLogic?
	
	func presentLoadingMore() {
		view?.displayItems(viewModel: .init(state: .loadingMore))
	}
	
	func presentItems(response: Photos.ShowItems.Response) {
		let viewModel: Photos.ShowItems.ViewModel
		switch response.result {
		case .failure(_):
			viewModel = Photos.ShowItems.ViewModel(state: .error)
		case .success(let result):
			if result.isEmpty {
				viewModel = Photos.ShowItems.ViewModel(state: .emptyResult)
			} else {
				let viewModels = result.map { model -> PhotoViewModel in
					let title = "\(model.ownerId)_\(model.uid)"
					let loadingDate = formattedDate(model.date)
					let urlAndRatio = urlStringAndAspectRatio(from: model.sizes)
					return PhotoViewModel(
						uid: model.uid,
						title: title,
						description: model.text,
						loadDate: loadingDate,
						urlString: urlAndRatio.url,
						aspectRatio: urlAndRatio.aspectRatio,
						isLiked: model.likes.userLikes != 0,
						likes: model.likes.count,
						comments: model.comments.count,
						reposts: model.reposts.count,
						tags: model.tags.count)
				}
				viewModel = Photos.ShowItems.ViewModel(state: .result(viewModels))
			}
		}
		view?.displayItems(viewModel: viewModel)
	}
	
	private func formattedDate(_ date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		return dateFormatter.string(from: Date(timeIntervalSince1970: date.timeIntervalSinceReferenceDate))
	}
	
	private func urlStringAndAspectRatio(from sizes: [PhotoSize]) -> (url: String?, aspectRatio: Double) {
		var url: String? = nil
		var aspectRatio = 16.0 / 9.0
		if let size = sizes.last {
			url = size.url
			if size.height != 0 {
				aspectRatio = Double(size.width) / Double(size.height)
			}
		}
		return (url, aspectRatio)
	}
}

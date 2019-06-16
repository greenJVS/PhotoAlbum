//
//  PhotosRouter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 15/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol PhotosRoutingLogic {
	func openPhoto(photoId: UniqueIdentifier)
}

protocol PhotosDataPassing {
	func set(albumId: String)
}

class PhotosRouter: PhotosRoutingLogic, PhotosDataPassing {
	private var albumId = ""
	
	weak var viewController: UIViewController?
	
	func openPhoto(photoId: UniqueIdentifier) {
		let controller = PhotosViewerBuilder()
			.set(initialState: .initial(albumId: albumId, selected: photoId))
			.build()
		viewController?.present(controller, animated: true, completion: nil)
	}
	
	func set(albumId: String) {
		self.albumId = albumId
	}
}

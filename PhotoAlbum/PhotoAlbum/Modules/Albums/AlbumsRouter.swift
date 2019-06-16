//
//  AlbumsRouter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 11/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol AlbumsRoutingLogic {
	func routeToPhotos(in albumId: UniqueIdentifier, albumName: String)
}

protocol AlbumsDataPassing {
	func set(token: AccessToken)
}

class AlbumsRouter: AlbumsRoutingLogic & AlbumsDataPassing {
	private var accessToken: AccessToken?
	
	weak var viewController: UIViewController?
	
	func set(token: AccessToken) {
		self.accessToken = token
	}
	
	func routeToPhotos(in albumId: UniqueIdentifier, albumName: String) {
		guard let token = accessToken else { return }
		let controller = PhotosBuilder()
			.set(token: token)
			.set(initialState: .initial(id: albumId))
			.build()
		controller.title = albumName
		viewController?.navigationController?.pushViewController(controller, animated: true)
	}
}

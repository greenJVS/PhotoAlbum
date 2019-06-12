//
//  AlbumsBuilder.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AlbumsBuilder: ModuleBuilder {
	var token: AccessToken?
	
	func set(token: AccessToken) -> AlbumsBuilder {
		self.token = token
		return self
	}
	
	func build() -> UIViewController {
		if token == nil {
			fatalError("Need to set AccessToken! Call set(token:) before build().")
		}
		let service = VKAlbumsService(token: token!)
		let provider = AlbumProvider(service: service, dataStore: AlbumsMemoryDataStore.shared)
		
		let router = AlbumsRouter()
		let presenter = AlbumsPresenter()
		let interactor = AlbumsInteractor(presenter: presenter, provider: provider)
		let controller = AlbumsViewController(interactor: interactor, router: router)
		presenter.view = controller
		router.viewController = controller
		router.set(token: token!)
		
		return controller
	}
}

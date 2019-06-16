//
//  PhotosBuilder.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosBuilder: ModuleBuilder {
	var token: AccessToken?
	var initialState: Photos.ViewState?
	
	func set(token: AccessToken) -> PhotosBuilder {
		self.token = token
		return self
	}
	
	func set(initialState: Photos.ViewState) -> PhotosBuilder {
		self.initialState = initialState
		return self
	}
	
	func build() -> UIViewController {
		if token == nil {
			fatalError("Need to set AccessToken! Call set(token:) before build().")
		}
		if initialState == nil {
			fatalError("Need to set InitialState! Call set(initialState:) before build().")
		}
		
		let service = VKPhotosService(token: token!)
		let provider = PhotosProvider(service: service, dataStore: PhotosMemoryDataStore.shared)
		
		let router = PhotosRouter()
		switch initialState! {
		case .initial(id: let albumId):
			router.set(albumId: "\(albumId)")
		default:
			break
		}
		let presenter = PhotosPresenter()
		let interactor = PhotosInteractor(presenter: presenter, provider: provider)
		let controller = PhotosViewController(interactor: interactor, router: router, initialState: initialState!)
		presenter.view = controller
		router.viewController = controller
		
		return controller
	}
}

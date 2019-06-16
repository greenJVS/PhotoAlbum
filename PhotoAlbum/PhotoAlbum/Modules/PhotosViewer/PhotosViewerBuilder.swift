//
//  PhotosViewerBuilder.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosViewerBuilder: ModuleBuilder {
	private var initialState: PhotosViewer.ViewState?
	
	func set(initialState: PhotosViewer.ViewState) -> PhotosViewerBuilder {
		self.initialState = initialState
		return self
	}
	
	func build() -> UIViewController {
		if initialState == nil {
			fatalError("Need to set InitialState! Call set(initialState:) before build().")
		}
		let presenter = PhotosViewerPresenter()
		let interactor = PhotosViewerInteractor(presenter: presenter)
		let controller = PhotosViewerViewController(interactor: interactor, initialState: initialState!)
		presenter.view = controller
		
		return controller
	}
}

//
//  PhotosViewerProvider.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 15/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol ProvidesPhotosViewer {
	func getPhotos(forAlbumId albumId: String, completion: @escaping ([PhotoModel]) -> Void)
}

struct PhotosViewerProvider: ProvidesPhotosViewer {
	let dataStore: StoresPhotos
	
	init(dataStore: StoresPhotos = PhotosMemoryDataStore.shared) {
		self.dataStore = dataStore
	}
	
	func getPhotos(forAlbumId albumId: String, completion: @escaping ([PhotoModel]) -> Void) {
		let photos = dataStore.photos(forAlbumId: albumId)
		completion(photos)
	}
}

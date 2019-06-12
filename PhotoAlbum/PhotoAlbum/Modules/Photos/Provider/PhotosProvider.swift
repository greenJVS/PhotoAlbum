//
//  PhotosProvider.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol ProvidesPhotos {
	func getPhotos(albumId: String, offset: Int, count: Int, completion: @escaping ([PhotoModel]?) -> Void)
}

struct PhotosProvider: ProvidesPhotos {
	let service: FetchesPhotos
	let dataStore: StoresPhotos
	
	init(service: FetchesPhotos, dataStore: StoresPhotos) {
		self.service = service
		self.dataStore = dataStore
	}
	
	func getPhotos(albumId: String, offset: Int, count: Int, completion: @escaping ([PhotoModel]?) -> Void) {
		let storedPhotos = dataStore.photos(forAlbumId: albumId, offset: offset, count: count)
		if storedPhotos?.isEmpty == false {
			return completion(storedPhotos)
		}
		
		service.fetchPhotos(
			albumId: albumId,
			offset: offset,
			count: count) { items in
				if let items = items {
					self.dataStore.save(photos: items, for: albumId)
				}
				completion(items)
		}
	}
}

//
//  PhotosDataStore.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol StoresPhotos: class {
	func photos(forAlbumId albumId: String, offset: Int, count: Int) -> [PhotoModel]?
	func save(photos: [PhotoModel], for albumId: String)
}

class PhotosMemoryDataStore: StoresPhotos {
	static let shared = PhotosMemoryDataStore()
	
	private var models: [String: [PhotoModel]] = [:]
	
	func photos(forAlbumId albumId: String, offset: Int, count: Int) -> [PhotoModel]? {
		guard let photos = models[albumId] else { return nil }
		let lastIndex = offset + count
		if photos.indices ~= offset {
			if photos.indices ~= lastIndex {
				return Array(photos[offset..<lastIndex])
			} else {
				return Array(photos[offset..<photos.endIndex])
			}
		}
		return nil
	}
	
	func save(photos: [PhotoModel], for albumId: String) {
		if models[albumId] != nil {
			models[albumId]?.append(contentsOf: photos)
		} else {
			models[albumId] = photos
		}
	}
}

//
//  AlbumsProvider.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol ProvidesAlbums {
	func getAlbums(completion: @escaping ([AlbumModel]?) -> Void)
	func name(forAlbum albumId: UniqueIdentifier) -> String
}

struct AlbumProvider: ProvidesAlbums {
	let service: FetchesAlbums
	let dataStore: StoresAlbums
	
	init(service: FetchesAlbums, dataStore: StoresAlbums) {
		self.service = service
		self.dataStore = dataStore
	}
	
	func getAlbums(completion: @escaping ([AlbumModel]?) -> Void) {
		if dataStore.models?.isEmpty == false {
			return completion(self.dataStore.models)
		}
		service.fetchAlbums { models in
			self.dataStore.models = models
			completion(models)
		}
	}
	
	func name(forAlbum albumId: UniqueIdentifier) -> String {
		return dataStore.models?.first(where: { $0.uid == albumId })?.title ?? ""
	}
}

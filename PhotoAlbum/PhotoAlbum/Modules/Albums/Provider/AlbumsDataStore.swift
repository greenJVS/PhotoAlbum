//
//  AlbumsDataStore.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol StoresAlbums: class {
	var models: [AlbumModel]? { get set }
}

class AlbumsMemoryDataStore: StoresAlbums {
	static let shared = AlbumsMemoryDataStore()
	var models: [AlbumModel]?
}

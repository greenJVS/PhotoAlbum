//
//  AlbumsInteractor.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol AlbumsBusinessLogic {
    func fetchItems(request: Albums.ShowItems.Request)
}

class AlbumsInteractor: AlbumsBusinessLogic {
    let presenter: AlbumsPresentationLogic
	let provider: ProvidesAlbums
	
	init(presenter: AlbumsPresentationLogic, provider: ProvidesAlbums) {
        self.presenter = presenter
		self.provider = provider
    }
    
    func fetchItems(request: Albums.ShowItems.Request) {
		provider.getAlbums { items in
			let result: Result<[AlbumModel], Albums.ShowItems.Response.Error>
			if let items = items {
				result = .success(items)
			} else {
				result = .failure(.fetchError)
			}
			self.presenter.presentItems(response: .init(result: result))
		}
    }
}

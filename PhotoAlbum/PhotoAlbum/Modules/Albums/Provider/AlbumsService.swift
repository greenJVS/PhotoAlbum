//
//  AlbumsService.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol FetchesAlbums {
    func fetchAlbums(completion: @escaping ([AlbumModel]?) -> Void)
}

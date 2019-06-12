//
//  PhotosService.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol FetchesPhotos {
	func fetchPhotos(albumId: String, offset: Int, count: Int, completion: @escaping ([PhotoModel]?) -> Void)
}

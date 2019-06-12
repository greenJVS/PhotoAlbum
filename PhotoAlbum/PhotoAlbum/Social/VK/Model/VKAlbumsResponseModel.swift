//
//  VKAlbumsResponseModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 10/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

struct VKItemsResponseModel<T: Decodable>: Decodable {
	struct Response: Decodable {
		let count: Int
		let items: [T]
	}
	let response: Response
}

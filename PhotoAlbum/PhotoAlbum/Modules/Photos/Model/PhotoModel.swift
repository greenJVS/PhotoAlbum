//
//  PhotoModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

struct PhotoModel: UniqueIdentifiable, Decodable {
	let uid: UniqueIdentifier
	let albumId: Int
	let ownerId: Int
	let sizes: [PhotoSize]
	let text: String
	let date: Date
	let likes: Likes
	let reposts: Count
	let comments: Count
	let canComment: Int
	let tags: Count

	enum CodingKeys: String, CodingKey {
		case uid = "id"
		case albumId = "album_id"
		case ownerId = "owner_id"
		case sizes
		case text
		case date
		case likes
		case reposts
		case comments
		case canComment = "can_comment"
		case tags
	}
}

struct PhotoSize: Decodable {
	enum SizeType: String, Decodable {
		case s, m, x, o, p, q, r, y, z, w
	}
	
	let type: SizeType
	let url: String
	let width: Int
	let height: Int
}

struct Count: Decodable {
	let count: Int
}

struct Likes: Decodable {
	let userLikes: Int
	let count: Int
	
	enum CodingKeys: String, CodingKey {
		case userLikes = "user_likes"
		case count
	}
}

extension PhotoModel: Equatable {
	static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
		return lhs.uid == rhs.uid
	}
}

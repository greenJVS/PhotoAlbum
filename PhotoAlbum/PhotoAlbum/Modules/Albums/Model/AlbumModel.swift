//
//  AlbumModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

struct AlbumModel: UniqueIdentifiable, Decodable {
    let uid: UniqueIdentifier
    let thumbId: Int
    let ownerId: Int
    let title: String
    let description: String?
    let created: Date?
    let updated: Date?
    let size: Int
    let thumbUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case thumbId = "thumb_id"
        case ownerId = "owner_id"
        case title
        case description
        case created
        case updated
        case size
        case thumbUrl = "thumb_src"
    }
}

extension AlbumModel: Equatable {
	static func == (lhs: AlbumModel, rhs: AlbumModel) -> Bool {
		return lhs.uid == rhs.uid
	}
}

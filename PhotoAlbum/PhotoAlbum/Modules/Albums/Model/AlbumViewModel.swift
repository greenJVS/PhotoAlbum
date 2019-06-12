//
//  AlbumViewModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

struct AlbumViewModel: UniqueIdentifiable {
    let uid: UniqueIdentifier
    let title: String
    let description: String?
	let size: String
	let imageUrl: String?
}

extension AlbumViewModel: Equatable {
	static func == (lhs: AlbumViewModel, rhs: AlbumViewModel) -> Bool {
		return lhs.uid == rhs.uid
	}
}

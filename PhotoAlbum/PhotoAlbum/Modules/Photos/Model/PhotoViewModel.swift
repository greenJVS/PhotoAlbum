//
//  PhotoViewModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

struct PhotoViewModel: UniqueIdentifiable {
	let uid: UniqueIdentifier
	let title: String
	let description: String
	let loadDate: String
	let urlString: String?
	let aspectRatio: Double
	
	let isLiked: Bool
	let likes: Int
	let comments: Int
	let reposts: Int
	let tags: Int
}

extension PhotoViewModel: Equatable {
	static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
		return lhs.uid == rhs.uid
	}
}

//
//  PhotosViewerPhotoViewModel.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

struct PhotosViewerPhotoViewModel: UniqueIdentifiable {
	let uid: UniqueIdentifier
	let url: URL
}

extension PhotosViewerPhotoViewModel: Equatable {
	static func == (lhs: PhotosViewerPhotoViewModel, rhs: PhotosViewerPhotoViewModel) -> Bool {
		return lhs.uid == rhs.uid
	}
}

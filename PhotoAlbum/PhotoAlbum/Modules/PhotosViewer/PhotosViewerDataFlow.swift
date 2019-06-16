//
//  PhotosViewerDataFlow.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

enum PhotosViewer {
	enum ShowItems {
		enum Request {
			case initial(albumId: String, selected: UniqueIdentifier)
		}
		
		struct Response {
			enum Error: Swift.Error {
				case fetchError
			}
			
			var result: Result<([PhotoModel], Int), Error>
		}
		
		struct ViewModel {
			var state: ViewState
		}
	}
	
	enum ViewState {
		case initial(albumId: String, selected: UniqueIdentifier)
		case loading
		case result(items: [PhotosViewerPhotoViewModel], selectedIndex: Int)
	}
}

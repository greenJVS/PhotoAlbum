//
//  PhotosDataFlow.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

enum Photos {
	enum ShowItems {
		enum Request {
			case initial(id: UniqueIdentifier)
			case more
		}
		
		struct Response {
			enum Error: Swift.Error {
				case fetchError
			}
			
			var result: Result<[PhotoModel], Error>
		}
		
		struct ViewModel {
			var state: ViewState
		}
	}
	
	enum ViewState {
		case initial(id: UniqueIdentifier)
		case loading
		case loadingMore
		case result([PhotoViewModel])
		case emptyResult
		case error
	}
}

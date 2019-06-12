//
//  AlbumsDataFlow.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

enum Albums {
    enum ShowItems {
        struct Request { }
        
        struct Response {
            enum Error: Swift.Error {
                case fetchError
            }
            
            var result: Result<[AlbumModel], Error>
        }
        
        struct ViewModel {
            var state: ViewState
        }
    }
    
    enum ViewState {
        case loading
        case result([AlbumViewModel])
        case emptyResult
        case error
    }
}

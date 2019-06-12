//
//  AlbumsPresenter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol AlbumsPresentationLogic {
    func presentItems(response: Albums.ShowItems.Response)
}

class AlbumsPresenter: AlbumsPresentationLogic {
    weak var view: AlbumsDisplayLogic?
    
    func presentItems(response: Albums.ShowItems.Response) {
        let viewModel: Albums.ShowItems.ViewModel
        switch response.result {
        case .failure(_):
            viewModel = Albums.ShowItems.ViewModel(state: .error)
        case .success(let result):
            if result.isEmpty {
                viewModel = Albums.ShowItems.ViewModel(state: .emptyResult)
            } else {
                let viewModels = result.map {
					AlbumViewModel(uid: $0.uid, title: $0.title, description: $0.description, size: "\($0.size) photo", imageUrl: $0.thumbUrl)
                }
                viewModel = Albums.ShowItems.ViewModel(state: .result(viewModels))
            }
        }
        view?.displayItems(viewModel: viewModel)
    }
}

//
//  AlbumsTableDelegate.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 10/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AlbumsTableDelegate: NSObject, UITableViewDelegate {
	weak var delegate: AlbumsViewControllerDelegate?
	
	var viewModels: [AlbumViewModel]
	
	init(viewModels: [AlbumViewModel] = []) {
		self.viewModels = viewModels
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		defer { tableView.deselectRow(at: indexPath, animated: true) }
		if let viewModel = viewModels[safe: indexPath.row] {
			delegate?.openAlbum(viewModel.uid)
		}
	}
	
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return UITableView.automaticDimension
//	}
}

//
//  PhotosTableDelegate.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosTableDelegate: NSObject, UITableViewDelegate {
	weak var delegate: PhotosViewControllerDelegate?
	
	var viewModels: [PhotoViewModel]
	
	init(viewModels: [PhotoViewModel] = []) {
		self.viewModels = viewModels
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		defer { tableView.deselectRow(at: indexPath, animated: true) }
		if let viewModel = viewModels[safe: indexPath.row] {
			delegate?.openPhoto(photoId: viewModel.uid)
		}
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if viewModels.endIndex - 1 == indexPath.row {
			delegate?.willShowLastPhoto()
		}
	}
}

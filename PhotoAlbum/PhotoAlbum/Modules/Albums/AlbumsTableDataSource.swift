//
//  AlbumsTableDataSource.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 10/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AlbumsTableDataSource: NSObject, UITableViewDataSource {
	private let cellReuseIdentifier = String(describing: AlbumTableViewCell.self)
	private let imageProvider: ImageProvider
	
	var viewModels: [AlbumViewModel]
	
	init(viewModels: [AlbumViewModel] = [], imageProvider: ImageProvider = .shared) {
		self.viewModels = viewModels
		self.imageProvider = imageProvider
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? AlbumTableViewCell,
			let viewModel = viewModels[safe: indexPath.row] {
			cell.configure(with: viewModel)
			if let imageUrl = viewModel.imageUrl {
				imageProvider.loadImageData(imageUrl) { data in
					if let image = UIImage(data: data) {
						DispatchQueue.main.async {
							let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell
							cell?.setImage(image)
						}
					}
				}
			}
			return cell
		}
		return UITableViewCell()
	}
	
}

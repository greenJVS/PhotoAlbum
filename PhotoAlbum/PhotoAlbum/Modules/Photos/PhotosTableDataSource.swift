//
//  PhotosTableDataSource.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosTableDataSource: NSObject, UITableViewDataSource {
	private let cellReuseIdentifier = String(describing: PhotoTableViewCell.self)
	private let imageProvider: ImageProvider
	
	var viewModels: [PhotoViewModel]
	
	init(viewModels: [PhotoViewModel] = [], imageProvider: ImageProvider = .shared) {
		self.viewModels = viewModels
		self.imageProvider = imageProvider
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? PhotoTableViewCell,
			let viewModel = viewModels[safe: indexPath.row] {
			cell.configure(with: viewModel)
			if let imageUrl = viewModel.urlString {
				imageProvider.loadImageData(imageUrl) { data in
					if let image = UIImage(data: data) {
						DispatchQueue.main.async {
							let cell = tableView.cellForRow(at: indexPath) as? PhotoTableViewCell
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

//
//  PhotosViewerViewController.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol PhotosViewerDisplayLogic: class {
	func displayItems(viewModel: PhotosViewer.ShowItems.ViewModel)
}

class PhotosViewerViewController: UIViewController {
	let interactor: PhotosViewerBusinessLogic
	private var state: PhotosViewer.ViewState {
		didSet (prevState) {
			switch (prevState, state) {
			case (.initial(let albumId, let selected), .loading):
				applyLoadingState(albumId: albumId, selected: selected)
			case (.loading, .result(let items, let selected)):
				applyLoadedResult(viewModels: items, selectedIndex: selected)
			default:
				break
			}
		}
	}
	
	private lazy var customView = view as? PhotosViewerView
	private var currentIndex = 0
	
	init(interactor: PhotosViewerBusinessLogic, initialState: PhotosViewer.ViewState) {
		self.interactor = interactor
		self.state = initialState
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		let photoViewerView = PhotosViewerView()
		photoViewerView.photosView.delegate = self
		photoViewerView.delegate = self
		view = photoViewerView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		modalTransitionStyle = .crossDissolve
		state = .loading
	}
	
	private func applyLoadingState(albumId: String, selected: UniqueIdentifier) {
		interactor.fetchItems(request: .initial(albumId: albumId, selected: selected))
	}
	
	private func applyLoadedResult(viewModels: [PhotosViewerPhotoViewModel], selectedIndex: Int) {
		self.currentIndex = selectedIndex
		customView?.photosView.photosCount = viewModels.count
		customView?.photosView.selectPhoto(at: selectedIndex)
		let imageProvider = ImageProvider.shared
		viewModels.enumerated().forEach { (index, photo) in
			imageProvider.loadImageData(photo.url, completion: { [weak self] data in
				guard let self = self else { return }
				guard let image = UIImage(data: data) else { return }
				DispatchQueue.main.async {
					self.customView?.photosView.set(photo: image, index: index)
				}
			})
		}
	}
}

extension PhotosViewerViewController: PhotosViewerDisplayLogic {
	func displayItems(viewModel: PhotosViewer.ShowItems.ViewModel) {
		state = viewModel.state
	}
}

extension PhotosViewerViewController: PhotosViewerViewDelegate {
	func photosViewerViewTapClose(_ photosViewerView: PhotosViewerView) {
		self.dismiss(animated: true, completion: nil)
	}
	
	func photosViewerViewTapShare(_ photosViewerView: PhotosViewerView) {
		if let image = customView?.photosView.getPhoto(forIndex: currentIndex) {
			let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
			self.present(controller, animated: true, completion: nil)
		}
	}
}

extension PhotosViewerViewController: UIScrollViewDelegate {
	private func isBouncing(scrollView: UIScrollView) -> Bool {
		if scrollView.contentOffset.x < -scrollView.contentInset.left {
			return true
		} else if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right {
			return true
		} else {
			return false
		}
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard let customView = customView?.photosView, customView === scrollView else { return }
		guard !isBouncing(scrollView: customView) else { return }
		let position = customView.positionFromContentOffset
		let offset = abs(CGFloat(currentIndex) - position)
		
		if 1 - offset < 0.1 {
			let index = Int(position.rounded())
			if index != currentIndex {
				currentIndex = index
			}
		}
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		guard let customView = customView?.photosView, customView === scrollView else { return }
		guard !isBouncing(scrollView: customView) else { return }
		let halfPageWidth = customView.pageWidth * 0.5
		var newIndex = currentIndex
		
		let dX = targetContentOffset.pointee.x - customView.offsetForPhoto(at: currentIndex).x
		if dX < -halfPageWidth {
			newIndex -= 1
		} else if dX > halfPageWidth {
			newIndex += 1
		} else if abs(velocity.x) >= 0.25 {
			if velocity.x > 0 {
				newIndex += 1
			} else {
				newIndex -= 1
			}
		}
		newIndex = max(0, min(customView.photosCount - 1, newIndex))
		if newIndex != currentIndex {
			currentIndex = newIndex
		}
		targetContentOffset.pointee.x = customView.offsetForPhoto(at: currentIndex).x
	}
}

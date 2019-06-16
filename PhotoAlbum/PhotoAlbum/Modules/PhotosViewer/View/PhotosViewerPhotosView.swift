//
//  PhotosViewerPhotosView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 14/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotosViewerPhotosView: UIScrollView {
	private var itemViews: [PhotoViewerPhotoView?] = []
	
	private var _photosCount: Int = 0
	var photosCount: Int {
		get {
			return _photosCount
		}
		set {
			_photosCount = newValue
			contentSize = .init(width: CGFloat(newValue) * cellWidth - additionalWidth, height: 0)
			itemViews = .init(repeating: nil, count: newValue)
		}
	}
	
	var positionFromContentOffset: CGFloat {
		return contentOffset.x / cellWidth
	}
	
	private let additionalWidth: CGFloat = 20
	
	private var cellWidth: CGFloat {
		return pageWidth + additionalWidth
	}
	var pageWidth: CGFloat {
		return UIScreen.main.bounds.width
	}
	private var pageHeight: CGFloat {
		return UIScreen.main.bounds.height
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .black
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		decelerationRate = .fast
		alwaysBounceHorizontal = true
		alwaysBounceVertical = false
		delaysContentTouches = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func selectPhoto(at index: Int, animated: Bool = false) {
		setContentOffset(offsetForPhoto(at: index), animated: animated)
	}
	
	func set(photo: UIImage, index: Int) {
		if itemViews[index] == nil {
			let photoView = PhotoViewerPhotoView()
			photoView.image = photo
			addSubview(photoView)
			itemViews[index] = photoView
		} else {
			itemViews[index]?.image = photo
		}
		let rect = cellRectForPhoto(at: index)
		itemViews[index]?.frame = rect
	}
	
	func getPhoto(forIndex index: Int) -> UIImage? {
		return itemViews[safe: index]??.image
	}
	
	func offsetForPhoto(at index: Int) -> CGPoint {
		return .init(x: CGFloat(index) * cellWidth, y: 0)
	}
	
	private func cellRectForPhoto(at index: Int) -> CGRect {
		return .init(origin: offsetForPhoto(at: index), size: .init(width: pageWidth, height: pageHeight))
	}
}

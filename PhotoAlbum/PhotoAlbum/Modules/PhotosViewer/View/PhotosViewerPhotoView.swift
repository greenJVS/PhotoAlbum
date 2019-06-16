//
//  PhotosViewerPhotoView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 15/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotoViewerPhotoView: UIView {
	
	private let scrollView = UIScrollView()
	private let contentView = UIImageView()
	
	var contentSize: CGSize {
		return contentView.image?.size ?? .zero
	}
	
	var image: UIImage? {
		get {
			return contentView.image
		}
		set {
			contentView.image = newValue
			scrollView.zoomScale = 1
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureScrollView()
		configureContentView()
		createUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureScrollView() {
		scrollView.alwaysBounceVertical = false
		scrollView.alwaysBounceHorizontal = true
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.contentInsetAdjustmentBehavior = .never
		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 4
		scrollView.backgroundColor = .clear
		scrollView.delegate = self
	}
	
	private func configureContentView() {
		contentView.contentMode = .scaleAspectFit
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.backgroundColor = .clear
	}
	
	private func createUI() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			scrollView.edges(to: self)
		)
	}
}

extension PhotoViewerPhotoView: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return contentView
	}
}

//
//  PhotosViewerView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 16/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol PhotosViewerViewDelegate: class {
	func photosViewerViewTapClose(_ photosViewerView: PhotosViewerView)
	func photosViewerViewTapShare(_ photosViewerView: PhotosViewerView)
}

class PhotosViewerView: UIView {
	struct Appearance {
		let closeButtonTopInset: CGFloat = 16
		let closeButtonRightInset: CGFloat = 16
	}
	private let appearance = Appearance()
	weak var delegate: PhotosViewerViewDelegate?
	
	let photosView = PhotosViewerPhotosView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func createUI() {
		let closeButton = UIButton(type: .system)
		closeButton.setTitle("Close", for: .normal)
		closeButton.addTarget(self, action: #selector(closeButtonTap(_:)), for: .touchUpInside)
		
		let shareButton = UIButton(type: .system)
		shareButton.setTitle("➥", for: .normal)
		shareButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
		shareButton.addTarget(self, action: #selector(shareButtonTap(_:)), for: .touchUpInside)
		
		[photosView, closeButton, shareButton].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		NSLayoutConstraint.activate(
			photosView.edges(to: self) + [
				closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: appearance.closeButtonTopInset),
				closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -appearance.closeButtonRightInset),
				
				shareButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -appearance.closeButtonTopInset),
				shareButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -appearance.closeButtonRightInset),
			]
		)
	}
	
	@objc
	private func closeButtonTap(_ sender: UIButton) {
		delegate?.photosViewerViewTapClose(self)
	}
	
	@objc
	private func shareButtonTap(_ sender: UIButton) {
		delegate?.photosViewerViewTapShare(self)
	}
}

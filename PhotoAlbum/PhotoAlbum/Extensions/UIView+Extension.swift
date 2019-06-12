//
//  UIView+Extension.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 11/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

extension UIView {
	func edges(to view: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
		return [
			self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
			self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant),
			self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
		]
	}
}

//
//  Array+Extension.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 10/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

extension Array {
	subscript (safe index: Int) -> Element? {
		return indices ~= index ? self[index] : nil
	}
}

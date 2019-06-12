//
//  ImageProvider.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 10/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

extension ImageProvider {
	enum Configuration {
		static let networkTimeout: TimeInterval = 30
	}
}

class ImageProvider {
	
	static let shared = ImageProvider()
	
	let urlSession: URLSession
	
	init(urlSession: URLSession = URLSession.shared) {
		self.urlSession = urlSession
	}
	
	func loadImageData(_ urlString: String, completion: @escaping((Data) -> Void)) {
		
		guard let url = URL(string: urlString) else { return completion(Data())  }
		
		let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: Configuration.networkTimeout)
		
		urlSession.dataTask(with: urlRequest) { (data, _, error) in
			guard
				error == nil,
				let data = data
				else { return completion(Data()) }
			
			completion(data)
			
			}.resume()
	}
}

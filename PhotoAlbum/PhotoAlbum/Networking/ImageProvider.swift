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
	private let cache: URLCache
	
	init(urlSession: URLSession = URLSession.shared, cache: URLCache = .shared) {
		self.urlSession = urlSession
		self.cache = cache
	}
	
	func loadImageData(_ url: URL, completion: @escaping (Data) -> Void) {
		let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: Configuration.networkTimeout)
		urlSession.dataTask(with: urlRequest) { (data, response, error) in
			if error != nil {
				if let cachedResponse = self.cache.cachedResponse(for: urlRequest) {
					return completion(cachedResponse.data)
				}
			}
			guard let data = data else { return }
			if let response = response {
				let cachedResponse = CachedURLResponse(response: response, data: data)
				self.cache.storeCachedResponse(cachedResponse, for: urlRequest)
			}
			completion(data)
			}.resume()
	}
	
	func loadImageData(_ urlString: String, completion: @escaping((Data) -> Void)) {
		guard let url = URL(string: urlString) else { return completion(Data())  }
		loadImageData(url, completion: completion)
	}
}

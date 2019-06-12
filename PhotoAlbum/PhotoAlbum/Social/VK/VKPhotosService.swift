//
//  VKPhotosService.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import VK_ios_sdk

class VKPhotosService: FetchesPhotos {
	let token: AccessToken
	let apiClient: APIClient
	
	private lazy var apiVersion = "5.95"
	
	init(token: AccessToken,
		 apiClient: APIClient = APIClient(baseURL: URL(string: "https://api.vk.com/method/")!)) {
		self.token = token
		self.apiClient = apiClient
	}
	
	func fetchPhotos(albumId: String, offset: Int, count: Int, completion: @escaping ([PhotoModel]?) -> Void) {
		let request = APIRequest(method: .post, path: "photos.get")
		request.queryItems = [
//			URLQueryItem(name: "photo_sizes", value: "1"),
			URLQueryItem(name: "album_id", value: albumId),
			URLQueryItem(name: "extended", value: "1"),
			URLQueryItem(name: "offset", value: "\(offset)"),
			URLQueryItem(name: "count", value: "\(count)"),
			URLQueryItem(name: "access_token", value: token),
			URLQueryItem(name: "v", value: apiVersion)
		]
		apiClient.perform(request) { (result) in
			switch result {
			case .success(let response):
				if let responseModel = try? response.decode(to: VKItemsResponseModel<PhotoModel>.self) {
					let items = responseModel.body.response.items
					DispatchQueue.main.async {
						completion(items)
					}
				} else {
					DispatchQueue.main.async {
						completion(nil)
					}
				}
			case .failure(_):
				DispatchQueue.main.async {
					completion(nil)
				}
			}
		}
	}
}

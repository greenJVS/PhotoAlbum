//
//  AuthProvider.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 11/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol ProvidesAuthorization {
	var accessToken: AccessToken? { get }
	func login(completion: @escaping (_ error: AuthError?) -> Void)
	func wakeUpSession(completion: @escaping (_ isValid: Bool) -> Void)
}

class AuthProvider: ProvidesAuthorization {
	private(set) lazy var accessToken: AccessToken? = tokenStorage.getToken(forKey: service.accessTokenStorageKey)
	
	let service: AuthService
	let tokenStorage: TokenStorage
	
	init(service: AuthService,
		 tokenStorage: TokenStorage) {
		self.service = service
		self.tokenStorage = tokenStorage
	}
	
	func login(completion: @escaping (_ error: AuthError?) -> Void) {
		service.login { [weak self] result in
			guard let self = self else { return	}
			switch result {
			case .success(let token):
				self.accessToken = token
				self.tokenStorage.setToken(token, forKey: self.service.accessTokenStorageKey)
				completion(nil)
			case .failure(let error):
				completion(error)
			}
		}
	}
	
	func wakeUpSession(completion: @escaping (_ isValid: Bool) -> Void) {
		service.wakeUpSession(completion: completion)
	}
}

//
//  AuthService.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

typealias AccessToken = String

protocol AuthService {
	var accessTokenStorageKey: String { get }
    func login(completion: @escaping (Result<AccessToken, AuthError>) -> Void)
    func wakeUpSession(completion: @escaping (_ isValid: Bool) -> Void)
}

struct AuthError: Error {
    let message: String
}


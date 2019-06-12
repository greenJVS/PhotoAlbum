//
//  TokenDataStorage.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation

protocol TokenStorage {
    func getToken(forKey key: String) -> AccessToken?
    func setToken(_ token: AccessToken, forKey key: String)
}

extension UserDefaults: TokenStorage {
    func getToken(forKey key: String) -> AccessToken? {
        return self.string(forKey: key)
    }
    
    func setToken(_ token: AccessToken, forKey key: String) {
        self.set(token, forKey: key)
    }
}

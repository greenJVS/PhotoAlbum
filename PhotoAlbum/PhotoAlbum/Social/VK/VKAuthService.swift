//
//  VKAuthService.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKAuthService: NSObject, AuthService {
	let accessTokenStorageKey: String = "VK_AccessToken"
	
    private let scope = [VK_PER_PHOTOS, ""]
    private let sdkInstance: VKSdk?
    private var completion: ((Result<AccessToken, AuthError>) -> Void)? = nil
    
    init(sdk: VKSdk?) {
        self.sdkInstance = sdk
        super.init()
		sdkInstance?.register(self)
    }
    
    func login(completion: @escaping (Result<AccessToken, AuthError>) -> Void) {
        self.completion = completion
		VKSdk.authorize([self.scope])
    }
    
    func wakeUpSession(completion: @escaping (Bool) -> Void) {
        VKSdk.wakeUpSession([scope]) { (state, error) in
            completion(error == nil && (state == .authorized || state == .initialized))
        }
    }
}

extension VKAuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result?.token?.accessToken {
            completion?(.success(token))
		} else {
			let error = AuthError(message: "VK Authorization Error!")
			completion?(.failure(error))
		}
    }
    
    func vkSdkUserAuthorizationFailed() {
        let error = AuthError(message: "VK Authorization Error!")
        completion?(.failure(error))
    }
}

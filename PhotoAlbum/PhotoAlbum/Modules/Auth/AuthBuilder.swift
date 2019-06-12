//
//  AuthBuilder.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AuthBuilder: ModuleBuilder {
    private var authService: AuthService?
    private var tokenStorage: TokenStorage?
    
    func set(authService: AuthService) -> AuthBuilder {
        self.authService = authService
        return self
    }
    
    func set(tokenStorage: TokenStorage) -> AuthBuilder {
        self.tokenStorage = tokenStorage
        return self
    }
    
    func build() -> UIViewController {
        if authService == nil {
            fatalError("Need to set AuthService! Call set(authService:) before build().")
        }
        if tokenStorage == nil {
            fatalError("Need to set TokenStorage! Call set(tokenStorage:) before build().")
        }
		
		let provider = AuthProvider(service: authService!, tokenStorage: tokenStorage!)
		
        let presenter = AuthPresenter()
		let interactor = AuthInteractor(presenter: presenter, provider: provider)
        let router = AuthRouter()
        let controller = AuthViewController(interactor: interactor, router: router)
        presenter.view = controller
        router.viewController = controller
        
        return controller
    }
}

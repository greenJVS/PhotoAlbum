//
//  AuthInteractor.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol AuthBusinessLogic {
	var accessToken: AccessToken? { get }
    func didLoad()
    func login()
}

class AuthInteractor: AuthBusinessLogic {
	var accessToken: AccessToken? {
		return provider.accessToken
	}
	
    let presenter: AuthPresentationLogic
	let provider: ProvidesAuthorization
	let reachibilityService: ReachibilityService
	
    init(presenter: AuthPresentationLogic,
		 provider: ProvidesAuthorization,
		 reachibilityService: ReachibilityService = ReachibilityServiceImpl()) {
        self.presenter = presenter
        self.provider = provider
		self.reachibilityService = reachibilityService
    }
    
    func didLoad() {
		presenter.presentLoading()
        let isConnectionAvailable = reachibilityService.isConnectionAvailable()
        if isConnectionAvailable {
            print("Connetion available.")
			if provider.accessToken != nil {
				provider.wakeUpSession { [weak self] isValidSession in
					guard let self = self else { return }
					if isValidSession {
						self.presenter.presentLoggedIn()
					}
				}
			} else {
				presenter.presentLogin()
			}
        } else {
            print("Connection unavailable.")
        }
    }
    
    func login() {
		provider.login { error in
			guard error == nil else { return }
			self.presenter.presentLoggedIn()
		}
    }
}

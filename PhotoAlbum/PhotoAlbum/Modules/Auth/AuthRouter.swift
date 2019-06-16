//
//  AuthRouter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol AuthRoutingLogic {
    func routeToAlbums()
}

protocol AuthDataPassing {
	func set(token: AccessToken)
}

class AuthRouter: AuthRoutingLogic, AuthDataPassing {
	private var accessToken: AccessToken?
	
    weak var viewController: UIViewController?
	
	func set(token: AccessToken) {
		self.accessToken = token
	}
	
	func routeToAlbums() {
		guard let token = accessToken else { return }
		let controller = AlbumsBuilder()
			.set(token: token)
			.build()
		controller.title = "Albums"
		let nc = UINavigationController(rootViewController: controller)
		nc.navigationBar.prefersLargeTitles = true
		viewController?.present(nc, animated: true, completion: nil)
    }
}

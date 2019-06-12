//
//  AuthViewController.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol AuthDispayLogic: class {
	func showLogin()
    func showLoggedIn()
	func showLoading()
}

class AuthViewController: UIViewController {
    let interactor: AuthBusinessLogic
    let router: AuthRoutingLogic & AuthDataPassing
    
    private lazy var customView = view as? AuthView
	
    init(interactor: AuthBusinessLogic, router: AuthRoutingLogic & AuthDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AuthView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.didLoad()
    }
    
}

extension AuthViewController: AuthViewDelegate {
    func authViewTappedVK(_ authView: AuthView) {
        interactor.login()
    }
}

extension AuthViewController: AuthDispayLogic {
	func showLoggedIn() {
		guard let token = interactor.accessToken else { return }
		router.set(token: token)
		router.routeToAlbums()
	}
	
	func showLoading() {
		customView?.loadingView.isHidden = false
	}
	
    func showLogin() {
		customView?.loadingView.isHidden = true
    }
}

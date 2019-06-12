//
//  AuthPresenter.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

protocol AuthPresentationLogic {
	func presentLogin()
    func presentLoggedIn()
	func presentLoading()
}

class AuthPresenter: AuthPresentationLogic {
    weak var view: AuthDispayLogic?
	
	func presentLogin() {
		view?.showLogin()
	}
	
    func presentLoggedIn() {
        view?.showLoggedIn()
    }
	
	func presentLoading() {
		view?.showLoading()
	}
}

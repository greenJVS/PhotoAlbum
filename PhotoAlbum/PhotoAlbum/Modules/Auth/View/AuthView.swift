//
//  AuthView.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

protocol AuthViewDelegate: class {
    func authViewTappedVK(_ authView: AuthView)
}

class AuthView: UIView {
    weak var delegate: AuthViewDelegate?
	
	let loadingView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
	
    init(frame: CGRect = .zero, delegate: AuthViewDelegate?) {
        super.init(frame: frame)
        self.delegate = delegate
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Authorize with:"
        let vkButton = UIButton(type: .system)
        vkButton.translatesAutoresizingMaskIntoConstraints = false
        vkButton.setTitle("VK", for: .normal)
        vkButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        vkButton.addTarget(self, action: #selector(vkButtonTapped(_:)), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, vkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
		addLoadingView()
    }
	
	private func addLoadingView() {
		let activityView = UIActivityIndicatorView(style: .gray)
		addSubview(loadingView)
		loadingView.contentView.addSubview(activityView)
		
		[loadingView, activityView].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate(
			loadingView.edges(to: self) + [
				activityView.centerXAnchor.constraint(equalTo: loadingView.contentView.centerXAnchor),
				activityView.centerYAnchor.constraint(equalTo: loadingView.contentView.centerYAnchor),
			]
		)
		activityView.startAnimating()
	}
	
    @objc
    private func vkButtonTapped(_ sender: UIButton) {
        delegate?.authViewTappedVK(self)
    }
}

//
//  AlbumTableViewCell.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 09/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    struct Appearance {
		let leftInset: CGFloat = 24
        let inset: CGFloat = 8
		let titleTopPadding: CGFloat = 12
        let imageToInfoPadding: CGFloat = 16
		let imageToCountPadding: CGFloat = 2
		let imageCornerRadius: CGFloat = 36
        let descriptionPadding: CGFloat = 4
        let imageSize = CGSize(width: 72, height: 72)
    }
    
    let appearance = Appearance()
    
    private let activityView = UIActivityIndicatorView(style: .gray)
    private let previewImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
	private let countLabel = UILabel()
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureStyle()
        createUI()
		activityView.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        activityView.startAnimating()
        previewImageView.isHidden = true
    }
    
    func configure(with viewModel: AlbumViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
		countLabel.text = viewModel.size
    }
    
    func setImage(_ image: UIImage) {
        activityView.stopAnimating()
        previewImageView.image = image
        previewImageView.isHidden = false
    }
    
    private func createUI() {
        let imageContainer = UIView()
        imageContainer.addSubview(previewImageView)
        imageContainer.addSubview(activityView)
        contentView.addSubview(imageContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
		contentView.addSubview(countLabel)
		
        [previewImageView, activityView, imageContainer, titleLabel, descriptionLabel, countLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
		
		let countLabelCenterConstraint = countLabel.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor)
		countLabelCenterConstraint.priority = .defaultHigh
		NSLayoutConstraint.activate(
			previewImageView.edges(to: imageContainer) +
				[activityView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
				 activityView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
				 
				 imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: appearance.inset),
				 imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appearance.leftInset),
				 imageContainer.widthAnchor.constraint(equalToConstant: appearance.imageSize.width),
				 imageContainer.heightAnchor.constraint(equalToConstant: appearance.imageSize.height),
				 
				 titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: appearance.titleTopPadding),
				 titleLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: appearance.imageToInfoPadding),
				 titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.inset),
				 
				 descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: appearance.descriptionPadding),
				 descriptionLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: appearance.imageToInfoPadding),
				 descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.inset),
				 descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -appearance.inset),
				 
				 countLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: appearance.imageToCountPadding),
				 countLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: appearance.inset),
				 countLabelCenterConstraint,
				 countLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -appearance.inset)
			])
    }
    
    private func configureStyle() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
		titleLabel.numberOfLines = 0
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionLabel.textColor = .gray
		descriptionLabel.numberOfLines = 0
		countLabel.font = .preferredFont(forTextStyle: .footnote)
		countLabel.textColor = .gray
        previewImageView.contentMode = .scaleAspectFill
		previewImageView.clipsToBounds = true
		previewImageView.layer.cornerRadius = appearance.imageCornerRadius
        activityView.hidesWhenStopped = true
		accessoryType = .disclosureIndicator
    }
}

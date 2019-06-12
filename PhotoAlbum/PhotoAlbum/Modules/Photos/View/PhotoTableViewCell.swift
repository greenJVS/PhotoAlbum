//
//  PhotoTableViewCell.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 12/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
	struct Appearance {
		let maximumPhotoHeight: CGFloat = UIScreen.main.bounds.height * 0.5
		let padding: CGFloat = 16
		let titleToImageSpacing: CGFloat = 8
		let titleToDateSpacing: CGFloat = 8
		let descriptionToImageSpacing: CGFloat = 4
		let separatorTopSpacing: CGFloat = 8
		let infoTopSpacing: CGFloat = 12
		let infoBottomSpacing: CGFloat = 32
		let separatorHeight: CGFloat = 0.5
		let separatorInset: CGFloat = 16
	}
	
	let appearance = Appearance()
	
	private let activityView = UIActivityIndicatorView(style: .gray)
	private let photoImageView = UIImageView()
	private let photoContainer = UIView()
	private let titleLabel = UILabel()
	private let loadingDateLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let likesLabel = UILabel()
	private let tagsLabel = UILabel()
	private let commentsLabel = UILabel()
	private let repostsLabel = UILabel()
	
	private lazy var imageHeightConstraint = photoContainer.heightAnchor.constraint(equalToConstant: 0)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		configureStyle()
		createUI()
		activityView.startAnimating()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		activityView.startAnimating()
		photoImageView.isHidden = true
	}
	
	func configure(with viewModel: PhotoViewModel) {
		titleLabel.text = viewModel.title
		loadingDateLabel.text = viewModel.loadDate
		descriptionLabel.text = viewModel.description
		likesLabel.text = viewModel.isLiked ? "❤️\(viewModel.likes)" : "🖤\(viewModel.likes)"
		tagsLabel.text = "👫\(viewModel.tags)"
		commentsLabel.text = "💬\(viewModel.comments)"
		repostsLabel.text = "📢\(viewModel.reposts)"
		
		let width = self.contentView.frame.width
		let height = width / CGFloat(viewModel.aspectRatio)
		imageHeightConstraint.constant = min(height, appearance.maximumPhotoHeight)
		updateConstraints()
	}
	
	func setImage(_ image: UIImage) {
		activityView.stopAnimating()
		photoImageView.image = image
		photoImageView.isHidden = false
	}
	
	private func configureStyle() {
		titleLabel.font = .preferredFont(forTextStyle: .headline)
		titleLabel.textColor = .darkText
		titleLabel.numberOfLines = 0
		loadingDateLabel.font = .preferredFont(forTextStyle: .footnote)
		loadingDateLabel.textColor = .gray
		descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
		descriptionLabel.textColor = .darkText
		descriptionLabel.numberOfLines = 0
		[likesLabel, tagsLabel, commentsLabel, repostsLabel].forEach {
			$0.font = .preferredFont(forTextStyle: .subheadline)
			$0.textColor = .lightGray
		}
		photoImageView.contentMode = .scaleAspectFit
	}
	
	private func createUI() {
		let stackView = UIStackView(arrangedSubviews: [likesLabel, tagsLabel, commentsLabel, repostsLabel])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		
		let separator = UIView()
		separator.backgroundColor = .lightGray
		
		contentView.addSubview(photoContainer)
		contentView.addSubview(titleLabel)
		contentView.addSubview(loadingDateLabel)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(separator)
		contentView.addSubview(stackView)
		photoContainer.addSubview(photoImageView)
		photoContainer.addSubview(activityView)
		
		[activityView, photoImageView, photoContainer, titleLabel, loadingDateLabel, descriptionLabel, separator, stackView, likesLabel, tagsLabel, commentsLabel, repostsLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		loadingDateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		
		let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -appearance.infoBottomSpacing)
		bottomConstraint.priority = .defaultHigh
		NSLayoutConstraint.activate(
			photoImageView.edges(to: photoContainer) + [
				activityView.centerXAnchor.constraint(equalTo: photoContainer.centerXAnchor),
				activityView.centerYAnchor.constraint(equalTo: photoContainer.centerYAnchor),
				
				photoContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
				photoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				photoContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
				imageHeightConstraint,
				
				titleLabel.topAnchor.constraint(equalTo: photoContainer.bottomAnchor, constant: appearance.titleToImageSpacing),
				titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appearance.padding),
				titleLabel.trailingAnchor.constraint(equalTo: loadingDateLabel.leadingAnchor, constant: -appearance.titleToDateSpacing),
				
				loadingDateLabel.topAnchor.constraint(equalTo: photoContainer.bottomAnchor, constant: appearance.titleToImageSpacing),
				loadingDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.padding),
				
				descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: appearance.descriptionToImageSpacing),
				descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appearance.padding),
				descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.padding),
				
				separator.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: appearance.separatorTopSpacing),
				separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appearance.separatorInset),
				separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.separatorInset),
				separator.heightAnchor.constraint(equalToConstant: appearance.separatorHeight),
				
				stackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: appearance.infoTopSpacing),
				stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appearance.padding),
				stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -appearance.padding),
				bottomConstraint
			])
	}
}

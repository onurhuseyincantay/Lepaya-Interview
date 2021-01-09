//
//  TrainerTableViewCell.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

final class TrainerTableViewCell: UITableViewCell {
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 8
    static let profileImageViewHeight: CGFloat = 50
    static let cardViewCornerRadius: CGFloat = 5
    static let stackViewSpacing: CGFloat = 4
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    addSubviews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: UI Components
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = ViewTraits.profileImageViewHeight / 2
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = ColorHelper.trainerUnAvailable.cgColor
    imageView.tintColor = .lightGray
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let cardView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewTraits.cardViewCornerRadius
    view.backgroundColor = .init(white: 0.98, alpha: 1)
    return view
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    return label
  }()
  
  private lazy var informationStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    stackView.spacing = ViewTraits.stackViewSpacing
    return stackView
  }()
}


// MARK: Public Functions
extension TrainerTableViewCell {
  
  func updateUI(with model: TrainerCellModel) {
    nameLabel.text = model.fullname
    emailLabel.text = model.email
    profileImageView.setCachedImage(from: model.profilePictureURL,
                                                   placeholder: ImageHelper.personImage,
                                                   isTemplate: false)
    profileImageView.layer.borderColor = model.isAvailable ? ColorHelper.trainerAvailable.cgColor : ColorHelper.trainerUnAvailable.cgColor
  }
}

private extension TrainerTableViewCell {
  
  func addSubviews() {
    backgroundColor = .clear
    contentView.addSubviewWithoutConstraints(view: cardView)
    cardView.addSubviewWithoutConstraints(view: profileImageView)
    cardView.addSubviewWithoutConstraints(view: informationStackView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.defaultPadding),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.defaultPadding),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.defaultPadding)
    ])
    setupCardViewConstraints()
  }
  
  func setupCardViewConstraints() {
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: ViewTraits.defaultPadding),
      profileImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,
                                                constant: ViewTraits.defaultPadding),
      profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor,
                                               constant: -ViewTraits.defaultPadding),
      profileImageView.widthAnchor.constraint(equalToConstant: ViewTraits.profileImageViewHeight),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
      
      informationStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
      informationStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: ViewTraits.defaultPadding),
      informationStackView.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -ViewTraits.defaultPadding)
    ])
  }
}

//
//  TrainerDetailsView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

protocol TrainerDetailsViewDelegate: TrainerDetailsViewController {
  
}

final class TrainerDetailsView: BaseView {
  private enum ViewTrait {
    static let companyBrandImageHeight: CGFloat = 150
    static let profileImageViewHeightWidth: CGFloat = 75
    
    static let defaultPadding: CGFloat = 16
    static let defaultVerticalPadding: CGFloat = 8
    static let defaultHorizontalPadding: CGFloat = 4
    static let availabilityViewHeightMultiplier: CGFloat = 0.25
    static let availabilityViewHeight = profileImageViewHeightWidth * availabilityViewHeightMultiplier
    static let availabilityTrailingBottomSpace = availabilityViewHeight / 8
    static let emailIconWidthHeight: CGFloat = 25
  }
  weak var delegate: TrainerDetailsViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    addSubviews()
    setupConstraints()
  }
  
  // MARK: UI Components
  private let companyBrandImageView: UIImageView = {
    let imageView = UIImageView(image: ImageHelper.lepayaLogo)
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let availabilityView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewTrait.availabilityViewHeight / 2
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    return view
  }()
  
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = ViewTrait.profileImageViewHeightWidth / 2
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private let sepereratorLine: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private let emailImageView: UIImageView = {
    let imageView = UIImageView(image: ImageHelper.emailIcon)
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = ColorHelper.lepayaBrandBlue
    return imageView
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    return label
  }()
}

// MARK: - Public
extension TrainerDetailsView {
  
  func updateUI(with trainer: Trainer) {
    profileImageView.setCachedImage(from: trainer.pictureURL, placeholder: ImageHelper.personIcon, isTemplate: false)
    availabilityView.backgroundColor = trainer.isAvailable ? ColorHelper.trainerAvailable : ColorHelper.trainerUnAvailable
    nameLabel.text = trainer.fullName
    emailLabel.text = trainer.email
  }
}

// MARK: - Private
private extension TrainerDetailsView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(companyBrandImageView)
    addSubviewWithoutConstraints(sepereratorLine)
    addSubviewWithoutConstraints(profileImageView)
    addSubviewWithoutConstraints(availabilityView)
    addSubviewWithoutConstraints(nameLabel)
    addSubviewWithoutConstraints(emailImageView)
    addSubviewWithoutConstraints(emailLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      companyBrandImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -ViewTrait.defaultPadding),
      companyBrandImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      companyBrandImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      companyBrandImageView.heightAnchor.constraint(equalToConstant: ViewTrait.companyBrandImageHeight),
      
      sepereratorLine.widthAnchor.constraint(equalTo: widthAnchor),
      sepereratorLine.heightAnchor.constraint(equalToConstant: 1),
      sepereratorLine.bottomAnchor.constraint(equalTo: companyBrandImageView.bottomAnchor),
      
      profileImageView.centerYAnchor.constraint(equalTo: companyBrandImageView.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      profileImageView.leadingAnchor.constraint(equalTo: companyBrandImageView.leadingAnchor, constant: ViewTrait.defaultPadding),
      profileImageView.widthAnchor.constraint(equalToConstant: ViewTrait.profileImageViewHeightWidth),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
      
      availabilityView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -ViewTrait.availabilityTrailingBottomSpace),
      availabilityView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -ViewTrait.availabilityTrailingBottomSpace),
      availabilityView.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: ViewTrait.availabilityViewHeightMultiplier),
      availabilityView.widthAnchor.constraint(equalTo: availabilityView.heightAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: companyBrandImageView.bottomAnchor, constant: ViewTrait.defaultPadding),
      nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: ViewTrait.defaultPadding),
      nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      
      emailImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      emailImageView.trailingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -ViewTrait.defaultHorizontalPadding),
      emailImageView.widthAnchor.constraint(equalToConstant: ViewTrait.emailIconWidthHeight),
      emailImageView.heightAnchor.constraint(equalTo: emailImageView.widthAnchor),
      
      emailLabel.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor),
      emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      emailLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
    ])
  }
}

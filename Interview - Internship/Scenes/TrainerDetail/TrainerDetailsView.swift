//
//  TrainerDetailsView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

// swiftlint:disable file_length
protocol TrainerDetailsViewDelegate: TrainerDetailsViewController {
  func didSelectTag(_ indexPath: IndexPath)
  func addedTag(_ tag: String?)
}

final class TrainerDetailsView: BaseView {
  weak var delegate: TrainerDetailsViewDelegate?
  
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
    static let minimumTextViewHeight: CGFloat = 150
  }
  
  private var inputContainerViewTopConstraint: NSLayoutConstraint?
  private var inputContainerViewBottomConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    tagsContainer.delegate = self
    addSubviews()
    setupConstraints()
    profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressProfilePicture)))
  }
  
  // MARK: UI Components
  private let companyBrandImageView: UIImageView = {
    let imageView = UIImageView(image: ImageHelper.lepayaLogo)
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let favoriteFruitLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorHelper.lepayaBrandBlue
    label.text = "Favorite Fruit:"
    return label
  }()
  
  private let favoriteFruitTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  
  private let ageLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorHelper.lepayaBrandBlue
    label.text = "Age:"
    return label
  }()
  
  private let ageTextField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  
  
  private let scrollableView: ScrollableView = {
    let view = ScrollableView()
    view.isUserInteractionEnabled = true
    view.containerView.backgroundColor = ColorHelper.trainerDetailBackgroundColor
    return view
  }()
  
  private lazy var tagInputContainerView: TagInputContainerView = {
    let container = TagInputContainerView()
    container.delegate = self
    return container
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
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  private let nameTextField: UITextField = {
    let textfield = UITextField()
    return textfield
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
  
  private let emailTextField: UITextField = {
    let textField = UITextField()
    textField.keyboardType = .emailAddress
    return textField
  }()
  
  private let tagsContainer = TagsContainerView()
  
  private let aboutTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.layer.borderWidth = 2
    textView.layer.borderColor = ColorHelper.lepayaBrandBlue.cgColor
    textView.layer.cornerRadius = 10
    textView.clipsToBounds = true
    return textView
  }()
}


// MARK: - TagInputContainerViewDelegate
extension TrainerDetailsView: TagInputContainerViewDelegate {
  
  func didPressClose() {
    animateTagInputContainerView(isExpanding: false) { _ in
      self.tagInputContainerView.removeFromSuperview()
    }
  }
  
  func didPressAddButton(tag: String?) {
    animateTagInputContainerView(isExpanding: false) { _ in
      self.tagInputContainerView.removeFromSuperview()
      self.delegate?.addedTag(tag)
    }
  }
  
  func addTag(tag: String) {
    tagsContainer.insertItem(with: tag)
  }
}


// MARK: - Public
extension TrainerDetailsView {
  
  func updateUI(with trainer: Trainer) {
    profileImageView.setCachedImage(from: trainer.pictureURL, placeholder: ImageHelper.personIcon, isTemplate: false)
    availabilityView.backgroundColor = trainer.isAvailable ? ColorHelper.trainerAvailable : ColorHelper.trainerUnAvailable
    nameTextField.text = trainer.fullName
    emailTextField.text = trainer.email
    tagsContainer.provideDataSource(trainer.tags, title: "Tags")
    aboutTextView.text = trainer.about
    ageTextField.text = DateFormatterHelper.calculateAge(from: trainer.bornDate)
    favoriteFruitTextField.text = trainer.favoriteFruit
  }
  
  func removeTag(at indexPath: IndexPath) {
    tagsContainer.removeItem(at: indexPath)
  }
}

extension TrainerDetailsView: TagsContainerViewDelegate {
  
  func didPressAdd() {
    setupTagInputContainerView()
    layoutIfNeeded()
    animateTagInputContainerView()
  }
  
  func didSelectItem(_ indexPath: IndexPath) {
    delegate?.didSelectTag(indexPath)
  }
}


@objc extension TrainerDetailsView {
  
  func didPressProfilePicture() {
    let isAvailable = availabilityView.backgroundColor == ColorHelper.trainerAvailable
    UIView.animate(withDuration: 0.5) {
      self.availabilityView.backgroundColor = isAvailable ? ColorHelper.trainerUnAvailable : ColorHelper.trainerAvailable
    }
  }
}

// MARK: - Private
private extension TrainerDetailsView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(scrollableView)
    let containerView = scrollableView.containerView
    containerView.addSubviewWithoutConstraints(companyBrandImageView)
    containerView.addSubviewWithoutConstraints(sepereratorLine)
    containerView.addSubviewWithoutConstraints(profileImageView)
    containerView.addSubviewWithoutConstraints(availabilityView)
    containerView.addSubviewWithoutConstraints(nameTextField)
    containerView.addSubviewWithoutConstraints(emailImageView)
    containerView.addSubviewWithoutConstraints(emailTextField)
    containerView.addSubviewWithoutConstraints(tagsContainer)
    containerView.addSubviewWithoutConstraints(aboutTextView)
    containerView.addSubviewWithoutConstraints(favoriteFruitLabel)
    containerView.addSubviewWithoutConstraints(favoriteFruitTextField)
    containerView.addSubviewWithoutConstraints(ageLabel)
    containerView.addSubviewWithoutConstraints(ageTextField)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      scrollableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollableView.containerView.heightAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.heightAnchor),
      
      companyBrandImageView.topAnchor.constraint(equalTo: scrollableView.containerView.topAnchor, constant: -ViewTrait.defaultPadding),
      companyBrandImageView.leadingAnchor.constraint(equalTo: scrollableView.containerView.leadingAnchor),
      companyBrandImageView.trailingAnchor.constraint(equalTo: scrollableView.containerView.trailingAnchor),
      companyBrandImageView.heightAnchor.constraint(equalToConstant: ViewTrait.companyBrandImageHeight),
      
      sepereratorLine.widthAnchor.constraint(equalTo: scrollableView.containerView.widthAnchor),
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
      
      nameTextField.topAnchor.constraint(equalTo: companyBrandImageView.bottomAnchor, constant: ViewTrait.defaultPadding),
      nameTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: ViewTrait.defaultPadding),
      nameTextField.trailingAnchor.constraint(lessThanOrEqualTo: scrollableView.containerView.trailingAnchor),
      
      emailImageView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      emailImageView.trailingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: -ViewTrait.defaultHorizontalPadding),
      emailImageView.widthAnchor.constraint(equalToConstant: ViewTrait.emailIconWidthHeight),
      emailImageView.heightAnchor.constraint(equalTo: emailImageView.widthAnchor),
      
      emailTextField.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor),
      emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
      emailTextField.trailingAnchor.constraint(lessThanOrEqualTo: scrollableView.containerView.trailingAnchor),
      
      tagsContainer.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      tagsContainer.leadingAnchor.constraint(equalTo: scrollableView.containerView.leadingAnchor, constant: ViewTrait.defaultPadding),
      tagsContainer.trailingAnchor.constraint(equalTo: scrollableView.containerView.trailingAnchor, constant: -ViewTrait.defaultPadding),
      
      aboutTextView.topAnchor.constraint(equalTo: tagsContainer.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      aboutTextView.leadingAnchor.constraint(equalTo: tagsContainer.leadingAnchor),
      aboutTextView.trailingAnchor.constraint(equalTo: tagsContainer.trailingAnchor),
      aboutTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTrait.minimumTextViewHeight),
      
      favoriteFruitLabel.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      favoriteFruitLabel.leadingAnchor.constraint(equalTo: aboutTextView.leadingAnchor),
      
      favoriteFruitTextField.topAnchor.constraint(equalTo: favoriteFruitLabel.topAnchor),
      favoriteFruitTextField.leadingAnchor.constraint(equalTo: favoriteFruitLabel.trailingAnchor),
      favoriteFruitTextField.trailingAnchor.constraint(equalTo: aboutTextView.trailingAnchor),
      
      ageLabel.topAnchor.constraint(equalTo: favoriteFruitLabel.bottomAnchor, constant: ViewTrait.defaultVerticalPadding),
      ageLabel.leadingAnchor.constraint(equalTo: favoriteFruitLabel.leadingAnchor),
      
      ageTextField.topAnchor.constraint(equalTo: ageLabel.topAnchor),
      ageTextField.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor),
      ageTextField.trailingAnchor.constraint(equalTo: aboutTextView.trailingAnchor),
      ageTextField.bottomAnchor.constraint(equalTo: scrollableView.containerView.bottomAnchor, constant: -ViewTrait.defaultVerticalPadding)
    ])
  }
  
  func setupTagInputContainerView() {
    addSubviewWithoutConstraints(tagInputContainerView)
    inputContainerViewTopConstraint = tagInputContainerView.topAnchor.constraint(equalTo: bottomAnchor)
    inputContainerViewTopConstraint?.priority = .defaultHigh
    
    inputContainerViewBottomConstraint = tagInputContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    inputContainerViewBottomConstraint?.priority = .defaultLow
    NSLayoutConstraint.activate([
      inputContainerViewTopConstraint!,
      tagInputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tagInputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      inputContainerViewBottomConstraint!
    ])
  }
  
  func animateTagInputContainerView(isExpanding: Bool = true, completion: ((Bool) -> Void)? = nil)  {
    inputContainerViewTopConstraint?.priority = isExpanding ? .defaultLow : .defaultHigh
    inputContainerViewBottomConstraint?.priority = isExpanding ? .defaultHigh : .defaultLow
    UIView.animate(withDuration: 0.5, animations: {
      self.layoutIfNeeded()
    }, completion: completion)
  }
}

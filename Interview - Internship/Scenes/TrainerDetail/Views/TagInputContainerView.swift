//
//  TagInputContainerView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit


protocol TagInputContainerViewDelegate: TrainerDetailsView {
  func didPressClose()
  func didPressAddButton(tag: String?)
}

final class TagInputContainerView: BaseView {
  
  weak var delegate: TagInputContainerViewDelegate?
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 16
    static let defaultVerticalPadding: CGFloat = 8
    static let buttonWidthHeight: CGFloat = 25
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
  
  // MARK: UI Components
  private let inputTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Add Tag"
    label.textAlignment = .center
    return label
  }()
  
  private let addButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(didPressAddButton), for: .touchUpInside)
    button.setImage(ImageHelper.plusIcon, for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    button.tintColor = ColorHelper.trainerAvailable
    return button
  }()
  
  private let closeButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(didPressClose), for: .touchUpInside)
    button.tintColor = ColorHelper.lepayaBrandOrange
    button.imageView?.contentMode = .scaleAspectFill
    button.setImage(ImageHelper.crossIcon, for: .normal)
    return button
  }()
}


// MARK: - Selectors
@objc extension TagInputContainerView {
  
  func didPressClose() {
    delegate?.didPressClose()
  }
  
  func didPressAddButton() {
    delegate?.didPressAddButton(tag: inputTextField.text)
  }
}


// MARK: - Constraints
private extension TagInputContainerView {
  
  func setupUIComponents() {
    layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    layer.cornerRadius = 25
    clipsToBounds = true
    backgroundColor = .white
  }
  
  func addSubviews() {
    addSubviewWithoutConstraints(closeButton)
    addSubviewWithoutConstraints(addButton)
    addSubviewWithoutConstraints(inputTextField)
    addSubviewWithoutConstraints(titleLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: topAnchor),
      closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.defaultPadding),
      closeButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidthHeight),
      closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
      
      addButton.topAnchor.constraint(equalTo: topAnchor),
      addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.defaultPadding),
      addButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidthHeight),
      addButton.widthAnchor.constraint(equalTo: addButton.widthAnchor),
      
      inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.defaultVerticalPadding),
      inputTextField.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
      inputTextField.trailingAnchor.constraint(equalTo: addButton.trailingAnchor),
      inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.defaultVerticalPadding)
    ])
  }
}

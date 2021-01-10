//
//  TagsCollectionViewCell.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

final class TagsCollectionViewCell: UICollectionViewCell {
  
  private enum ViewTraits {
    static let leadingTrailingIndent: CGFloat = 16
    static let descriptionHeight: CGFloat = 30
    static let topBottomIndent: CGFloat = 5
    static let closeImageViewHeightWidth: CGFloat = 15
    static let cornerRadius: CGFloat = 20
  }
  
  // MARK: UI Components
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = ColorHelper.lepayaBrandOrange
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public
extension TagsCollectionViewCell {
  
  func prepareCell(with tag: String) {
    descriptionLabel.text = "#\(tag)"
  }
}


// MARK: - Constraints Zone
private extension TagsCollectionViewCell {
  
  func setupUIComponents() {
    layer.borderColor = ColorHelper.lepayaBrandBlue.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = ViewTraits.cornerRadius
    clipsToBounds = true
  }
  
  func addSubviews() {
    addSubviewWithoutConstraints(descriptionLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.leadingTrailingIndent),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.leadingTrailingIndent),
      descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.topBottomIndent),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTraits.topBottomIndent),
      descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewTraits.descriptionHeight)
    ])
  }
}

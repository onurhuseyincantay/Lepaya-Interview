//
//  TagsContainerView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

protocol TagsContainerViewDelegate: BaseView {
  func didSelectItem(_ indexPath: IndexPath)
  func didPressAdd()
}

final class TagsContainerView: BaseView {
  weak var delegate: TagsContainerViewDelegate?
  
  private var dataSource: [String] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    addSubviews()
    setupConstraints()
  }
  
  // MARK: UI Components
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorHelper.lepayaBrandBlue
    return label
  }()
  
  private let addButton: UIButton = {
    let button = UIButton()
    button.setImage(ImageHelper.plusIcon, for: .normal)
    button.tintColor = ColorHelper.lepayaBrandBlue
    button.addTarget(self, action: #selector(didPressAdd), for: .touchUpInside)
    return button
  }()
  
  private lazy var collectionView: SelfSizedCollectionView = {
    let flowLayout = TagsFlowLayout()
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    let collectionView = SelfSizedCollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: TagsCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    return collectionView
  }()
}

// MARK: - Public Functions
extension TagsContainerView {
  
  func provideDataSource(_ dataSource: [String], title: String) {
    self.dataSource = dataSource
    titleLabel.text = title
    collectionView.reloadData()
  }
  
  func removeItem(at indexPath: IndexPath) {
    collectionView.performBatchUpdates {
      dataSource.remove(at: indexPath.row)
      collectionView.deleteItems(at: [indexPath])
    }
  }
  
  func insertItem(with tag: String) {
    collectionView.performBatchUpdates {
      dataSource.append(tag)
      collectionView.insertItems(at: [IndexPath(row: dataSource.count - 1, section: 0)])
    }
  }
}


// MARK: - UICollectionViewDataSource
extension TagsContainerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as? TagsCollectionViewCell else {
      fatalError("This view should only accept TagsCollectionViewCell")
    }
    let row = indexPath.row
    cell.prepareCell(with: dataSource[row])
    return cell
  }
}


// MARK: - UICollectionViewDelegate
extension TagsContainerView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelectItem(indexPath)
  }
}


@objc extension TagsContainerView {
  
  func didPressAdd() {
    delegate?.didPressAdd()
  }
}


// MARK: - Constraints
private extension TagsContainerView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(titleLabel)
    addSubviewWithoutConstraints(addButton)
    addSubviewWithoutConstraints(collectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      addButton.topAnchor.constraint(equalTo: topAnchor),
      addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      addButton.widthAnchor.constraint(equalToConstant: 50),
      addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
      
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

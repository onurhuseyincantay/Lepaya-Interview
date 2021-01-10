//
//  ScrollableView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

final class ScrollableView: BaseView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    setupConstraints()
  }
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.bounces = false
    return scrollView
  }()
  
  let containerView = UIView()
}


// MARK: - Constraints
private extension ScrollableView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(scrollView)
    scrollView.addSubviewWithoutConstraints(containerView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      containerView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor),
      containerView.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }
}

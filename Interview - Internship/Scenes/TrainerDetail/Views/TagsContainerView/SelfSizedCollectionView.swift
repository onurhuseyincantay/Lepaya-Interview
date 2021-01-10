//
//  SelfSizedCollectionView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

final class SelfSizedCollectionView: UICollectionView {
  
  override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return contentSize
  }
}

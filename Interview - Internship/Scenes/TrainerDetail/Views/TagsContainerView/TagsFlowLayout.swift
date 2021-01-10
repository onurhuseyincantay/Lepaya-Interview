//
//  TagsFlowLayout.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//


import UIKit
//swiftlint:disable unused_setter_value
final class TagsFlowLayout: UICollectionViewFlowLayout {
  
  override var minimumInteritemSpacing: CGFloat {
    get { return 4 }
    set { }
  }
  
  override var minimumLineSpacing: CGFloat {
    get { return 4 }
    set { }
  }
  
  private let roundingAmount: CGFloat = 10
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
      return nil
    }
    
    guard scrollDirection == .vertical else {
      return layoutAttributes
    }
    
    let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })
    // Group cell attributes by row (cells with same vertical center) and loop on those groups
    for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / roundingAmount).rounded(.up) * roundingAmount }) {
      // Set the initial left inset
      var leftInset = sectionInset.left
      // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
      for attribute in attributes {
        attribute.frame.origin.x = leftInset + minimumInteritemSpacing
        leftInset = attribute.frame.maxX + minimumInteritemSpacing
      }
    }
    return layoutAttributes
  }
}

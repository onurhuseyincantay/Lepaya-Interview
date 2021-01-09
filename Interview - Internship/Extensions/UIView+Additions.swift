//
//  UIView+Additions.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit


extension UIView {
  
  func addSubviewWithoutConstraints(view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
  }
}

//
//  Identifiable.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

// MARK: - Default Implementation
extension Identifiable {
  
  static var identifier: String { String(describing: Self.self) }
}


// MARK: - UITableViewCell + Identifiable
extension UITableViewCell: Identifiable { }

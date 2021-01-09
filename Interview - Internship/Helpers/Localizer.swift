//
//  Localizer.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation

enum Localizer {
  
  static func localize(key: String) -> String {
    Bundle.main.localizedString(forKey: key, value: nil, table: "Localizable")
  }
}

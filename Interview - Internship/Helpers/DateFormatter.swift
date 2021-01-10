//
//  DateFormatterHelper.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation

enum DateFormatterHelper {
  
  static func calculateAge(from date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss.SSS"
    let date = dateFormatter.date(from: date)!
    let components = Calendar.current.dateComponents([.year], from: date)
    let currrentYear = Calendar.current.dateComponents([.year], from: Date())
    return "\(currrentYear.year! - components.year!)"
  }
}

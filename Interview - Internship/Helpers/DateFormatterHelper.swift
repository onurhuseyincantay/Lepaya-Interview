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
    guard let formattedDate = dateFormatter.date(from: date) else {
      return calculateAgeUnsupportedFormat(from: date)
    }
    let components = Calendar.current.dateComponents([.year], from: formattedDate)
    let currrentYear = Calendar.current.dateComponents([.year], from: Date())
    return "\(currrentYear.year! - components.year!)"
  }
}

// MARK: - Private
private extension DateFormatterHelper {
  // didnt understand the time format and there is no locale given so will do a workaround but normally the upper function should parse every date it only parses the first one :/
  static func calculateAgeUnsupportedFormat(from date: String) -> String {
    let year = Int(date.split(separator: "-").first!)!
    let currrentYear = Calendar.current.dateComponents([.year], from: Date())
    return "\(currrentYear.year! - year)"
  }
}

//
//  TrainerList.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation


typealias TrainerList = [Trainer]

// MARK: - Trainer
struct Trainer: Decodable {
  let index: Int
  let guid: String
  let isAvailable: Bool
  let pictureURL: URL
  var name: Name
  var email, about, bornDate: String
  var tags: [String]
  let favoriteFruit: String
  // MARK: Computed Properties
  var fullName: String { "\(name.first) \(name.last)" }
  
  enum CodingKeys: String, CodingKey {
    case index, guid, isAvailable, name, email, about, bornDate, tags, favoriteFruit
    case pictureURL = "picture"
  }
}

// MARK: - Name
struct Name: Decodable {
  let first, last: String
}

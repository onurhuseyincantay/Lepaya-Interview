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
  let favoriteFruitType: FruitType
  // MARK: Computed Properties
  var fullName: String { "\(name.first) \(name.last)" }
  
  enum CodingKeys: String, CodingKey {
    case index, guid, isAvailable, name, email, about, bornDate, tags
    case favoriteFruitType = "favoriteFruit"
    case pictureURL = "picture"
  }
}

// MARK: - FruitType
enum FruitType: String, Decodable {
  case apple
  case avocado
  case banana
  case mango
  case strawberry
  case watermelon
}

// MARK: - Name
struct Name: Decodable {
  let first, last: String
}

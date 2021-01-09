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
    let picture: String
    let name: Name
    let email, about, bornDate: String
    let tags: [String]
    let favoriteFruit: FruitType
}

// MARK: - FruitType
enum FruitType: String, Decodable {
    case apple = "apple"
    case avocado = "avocado"
    case banana = "banana"
    case mango = "mango"
    case strawberry = "strawberry"
    case watermelon = "watermelon"
}

// MARK: - Name
struct Name: Decodable {
    let first, last: String
}


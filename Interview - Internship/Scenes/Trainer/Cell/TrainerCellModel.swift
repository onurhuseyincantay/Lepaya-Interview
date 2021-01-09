//
//  TrainerCellModel.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation

typealias TrainerDataSource = [TrainerCellModel]

struct TrainerCellModel {
  let fullname, email: String
  let profilePictureURL: URL
  let isAvailable: Bool
}

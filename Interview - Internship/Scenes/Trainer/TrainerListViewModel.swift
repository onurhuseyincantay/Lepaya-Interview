//
//  TrainerListViewModel.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation

protocol TrainerListViewModelProtocol {
  /// Loads Trainers from Datasource
  func loadTrainer() -> TrainerDataSource
  
  /// Returns the selected trainer
  /// - Parameter indexPath: ndexpath of the selected cell
  func selectTrainer(at indexPath: IndexPath) -> Trainer
}

final class TrainerListViewModel {
  var trainerList: TrainerList!
}


// MARK: - TrainerListViewModelProtocol
extension TrainerListViewModel: TrainerListViewModelProtocol {
  
  func loadTrainer() -> TrainerDataSource {
    let jsonReader = JSONReader()
    // normally force unwrap is not best practice but since we are using local files to load data I didnt want to have code noise
    // swiftlint:disable:next force_try
    trainerList = try! jsonReader.decodeJsonToObject(jsonName: "trainers")
    let dataSource = trainerList.map { TrainerCellModel(fullname: $0.fullName, email: $0.email, profilePictureURL: $0.pictureURL, isAvailable: $0.isAvailable) }
    return dataSource
  }
  
  func selectTrainer(at indexPath: IndexPath) -> Trainer {
    trainerList[indexPath.row]
  }
}

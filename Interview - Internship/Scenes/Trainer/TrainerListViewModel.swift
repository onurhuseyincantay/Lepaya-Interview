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
  
  
  /// Updates Existing Trainerr
  /// - Parameter trainer: Trainer to be update
  func updateTrainer(_ trainer: Trainer) -> (IndexPath, TrainerCellModel)
}

final class TrainerListViewModel {
  private var trainerList: TrainerList!
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
  
  func updateTrainer(_ trainer: Trainer) -> (IndexPath, TrainerCellModel) {
    guard let index = trainerList.index(of: trainer) else {
      fatalError()
    }
    trainerList[index] = trainer
    let trainerCellModel = TrainerCellModel(fullname: trainer.fullName, email: trainer.email, profilePictureURL: trainer.pictureURL, isAvailable: trainer.isAvailable)
    let indexPath = IndexPath(row: index, section: 0)
    return (indexPath, trainerCellModel)
  }
}

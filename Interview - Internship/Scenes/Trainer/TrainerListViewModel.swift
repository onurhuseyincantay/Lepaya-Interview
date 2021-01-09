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
  func loadTrainer() -> TrainerList
  
  func selectTrainer(at indexPath: IndexPath) -> Trainer
}

final class TrainerListViewModel {
  var trainerList: TrainerList!
}

// MARK: - TrainerListViewModelProtocol
extension TrainerListViewModel: TrainerListViewModelProtocol {
  
  func loadTrainer() -> TrainerList {
    let jsonReader = JSONReader()
    // normally force unwrap wouldnt be the case but since we are using local files to load data I didnt want to have code noise
    // swiftlint:disable:next force_try
    trainerList = try! jsonReader.decodeJsonToObject(jsonName: "trainers")
    return trainerList
  }
  
  func selectTrainer(at indexPath: IndexPath) -> Trainer {
    trainerList[indexPath.row]
  }
}

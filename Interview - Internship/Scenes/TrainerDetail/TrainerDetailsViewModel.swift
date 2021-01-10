//
//  TrainerDetailsViewModel.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import Foundation

protocol TrainerDetailsViewModelProtocol {
  var trainer: Trainer { get }
  
  /// İnitializer for the viewModel
  /// - Parameter trainer: Trainer That is required to be managed by the viewModel
  init(trainer: Trainer)
  
  /// Removes a tag from the trainer
  /// - Parameter indexPath: index of the tag to be removed
  func removeTag(at indexPath: IndexPath)
  
  /// adds a tag if possible and returns the successStatus
  /// - Parameter tag: tag to be added
  func addTag(_ tag: String?) -> Bool
  
  /// updates a trainer with updated fields and returns the updated trainer
  /// - Parameter model: TrainerUpdateModel
  func updateTrainer(_ model: TrainerUpdateModel) -> Trainer
}

final class TrainerDetailsViewModel {
  private(set) var trainer: Trainer
  
  init(trainer: Trainer) {
    self.trainer = trainer
  }
}


// MARK: - TrainerDetailsViewModelProtocol
extension TrainerDetailsViewModel: TrainerDetailsViewModelProtocol {
  
  func removeTag(at indexPath: IndexPath) {
    trainer.tags.remove(at: indexPath.row)
  }
  
  func addTag(_ tag: String?) -> Bool {
    guard let tag = tag else {
      return false
    }
    trainer.tags.append(tag)
    return true
  }
  
  func updateTrainer(_ model: TrainerUpdateModel) -> Trainer {
    trainer.about = model.about
    trainer.email = model.email
    let splittedFullName = model.name.split(separator: " ")
    trainer.name.first = String(splittedFullName.first ?? "")
    trainer.name.last = splittedFullName.count == 1 ? "" : String(splittedFullName.last ?? "")
    trainer.isAvailable = model.isAvailable
    trainer.favoriteFruit = model.favoriteFruit
    return trainer
  }
}

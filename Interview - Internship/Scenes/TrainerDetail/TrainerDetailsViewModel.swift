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
  
  init(trainer: Trainer)
  func removeTag(at indexPath: IndexPath)
  func addTag(_ tag: String?) -> Bool
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
    trainer.name.last = String(splittedFullName.last ?? "")
    trainer.isAvailable = model.isAvailable
    trainer.favoriteFruit = model.favoriteFruit
    return trainer
  }
}

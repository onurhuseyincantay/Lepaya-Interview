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
}

final class TrainerDetailsViewModel {
  private(set) var trainer: Trainer
  
  init(trainer: Trainer) {
    self.trainer = trainer
  }
}


// MARK: - TrainerDetailsViewModelProtocol
extension TrainerDetailsViewModel: TrainerDetailsViewModelProtocol {

}

//
//  TrainerDetailsViewController.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 31/01/2020.
//  Copyright © 2020 Lepaya. All rights reserved.
//

import UIKit

protocol TrainerDetailsViewControllerDelegate: TrainerListViewController {
  
}

final class TrainerDetailsViewController: UIViewController {
  weak var delegate: TrainerDetailsViewControllerDelegate?
  
  let mainView: TrainerDetailsView
  let viewModel: TrainerDetailsViewModelProtocol
  
  init(view: TrainerDetailsView, viewModel: TrainerDetailsViewModelProtocol) {
    mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    mainView.updateUI(with: viewModel.trainer)
  }
  
  override func loadView() {
    mainView.delegate = self
    view = mainView
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TrainerDetailsViewController: TrainerDetailsViewDelegate {
  
}

//
//  TrainerListViewController.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import UIKit

final class TrainerListViewController: UIViewController {
  
  let mainView: TrainerListView
  let viewModel: TrainerListViewModelProtocol
   
  init(view: TrainerListView, viewModel: TrainerListViewModelProtocol) {
    mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    title = Localizer.localize(key: "TrainerListViewControllerTitle")
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    mainView.delegate = self
    view = mainView
  }
  
  // MARK: Object LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.updateDataSource(dataSource: viewModel.loadTrainer())
  }
}


// MARK: - TrainerListViewDelegate
extension TrainerListViewController: TrainerListViewDelegate {
  
  func didSelectRow(at indexPath: IndexPath) {
    let trainer = viewModel.selectTrainer(at: indexPath)
    guard trainer.isAvailable else {
      showNotAvailableAlert()
      return
    }
    routeToTrainerViewController(with: trainer)
  }
}


// MARK: - Routing
private extension TrainerListViewController {
  
  func routeToTrainerViewController(with trainer: Trainer) {
    
  }
  
  func showNotAvailableAlert() {
    let title = Localizer.localize(key: "TrainerNotAvailableAlertTitle")
    let message = Localizer.localize(key: "TrainerNotAvailableAlertMessage")
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let actionTitle = Localizer.localize(key: "OkayButtonTitle")
    alert.addAction(UIAlertAction(title: actionTitle, style: .cancel))
    present(alert, animated: true, completion: nil)
  }
}

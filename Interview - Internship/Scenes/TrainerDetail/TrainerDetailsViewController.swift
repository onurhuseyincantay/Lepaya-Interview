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


// MARK: - TrainerDetailsViewDelegate
extension TrainerDetailsViewController: TrainerDetailsViewDelegate {
  
  func addedTag(_ tag: String?) {
    guard self.viewModel.addTag(tag) else {
      #warning("when the user provides an empty or nil field case should be handled")
      return
    }
    mainView.addTag(tag: tag!)
  }
  
  func didSelectTag(_ indexPath: IndexPath) {
    showDeleteActionSheet(indexPath)
  }
}


private extension TrainerDetailsViewController {
  
  func showDeleteActionSheet(_ indexPath: IndexPath) {
    let alert = UIAlertController(title: "Delete Tag", message: "Are you sure you want to delete this Tag ?", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
      self.mainView.removeTag(at: indexPath)
      // TODO: normally we should wait first for the UI Update before deleting the data but time limits :(
      self.viewModel.removeTag(at: indexPath)
    }))
    let cancelButtonTitle = Localizer.localize(key: "CancelButtonTitle")
    alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel))
    present(alert, animated: true)
  }
}

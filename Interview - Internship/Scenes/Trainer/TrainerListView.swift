//
//  TrainerListView.swift
//  Interview - Internship
//
//  Created by Onur Hüseyin Çantay on 9.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import UIKit

protocol TrainerListViewDelegate: TrainerListViewController {
  func didSelectRow(at indexPath: IndexPath)
}

final class TrainerListView: BaseView {
  weak var delegate: TrainerListViewDelegate?
  private var dataSource: TrainerDataSource = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = ColorHelper.lepayaBrandBlue
    addSubviews()
    setupConstraints()
  }
  
  // MARK: UI Components
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.register(TrainerTableViewCell.self, forCellReuseIdentifier: TrainerTableViewCell.identifier)
    return tableView
  }()
}


// MARK: - Public Functions
extension TrainerListView {
  
  func updateDataSource(dataSource: TrainerDataSource) {
    self.dataSource = dataSource
    tableView.reloadData()
  }
  
  func updateTrainer(at indexPath: IndexPath, with trainer: TrainerCellModel) {
    dataSource[indexPath.row] = trainer
    guard let cell = tableView.cellForRow(at: indexPath) as? TrainerTableViewCell else {
      return
    }
    cell.updateUI(with: trainer)
  }
}


// MARK: - UITableViewDelegate
extension TrainerListView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelectRow(at: indexPath)
  }
}


// MARK: - UITableViewDataSource
extension TrainerListView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainerTableViewCell.identifier, for: indexPath) as? TrainerTableViewCell else {
      return .init()
    }
    let trainer = dataSource[indexPath.row]
    cell.updateUI(with: trainer)
    return cell
  }
}

// MARK: - Constraints
private extension TrainerListView {
  func addSubviews() {
    addSubviewWithoutConstraints(tableView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

//
//  TrainersTests.swift
//  TrainersTests
//
//  Created by Onur Hüseyin Çantay on 10.01.2021.
//  Copyright © 2021 Lepaya. All rights reserved.
//

import XCTest
@testable import Trainers

final class TrainersTests: XCTestCase {
  private var sut: TrainerListViewModel!
  
  override func setUp() {
    super.setUp()
    sut = TrainerListViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
}


// MARK: - Tests
extension TrainersTests {
  
  func testLoadDataSource() {
    XCTAssertNotNil(sut.loadTrainer())
  }
  
  func testSelectTrainer() {
    let indexPath = IndexPath(row: 0, section: 0)
    let dataSource = sut.loadTrainer()
    let trainer = sut.selectTrainer(at: indexPath)
    let selectedTrainer = dataSource[indexPath.row]
    
    XCTAssertEqual(trainer.email, selectedTrainer.email)
    XCTAssertEqual(trainer.pictureURL, selectedTrainer.profilePictureURL)
    XCTAssertEqual(trainer.isAvailable, selectedTrainer.isAvailable)
  }
  
  func testUpdateTrainer() {
    let trainer = Trainer(index: 0,
                          guid: "3ffe4c99-4b3f-4a1a-94dd-451222153f2c",
                          isAvailable: false,
                          pictureURL: URL(string: "www.lepaya.com")!,
                          name: Name(first: "", last: ""),
                          email: "",
                          about: "",
                          bornDate: "",
                          tags: [],
                          favoriteFruit: "")
    _ = sut.loadTrainer()
    let (indexPath, trainerCellModel) = sut.updateTrainer(trainer)
    XCTAssertEqual(indexPath.row, 0)
    XCTAssertEqual(trainerCellModel.email, trainer.email)
    XCTAssertEqual(trainerCellModel.fullname, trainer.fullName)
    XCTAssertEqual(trainerCellModel.isAvailable, trainer.isAvailable)
    XCTAssertEqual(trainerCellModel.profilePictureURL, trainer.pictureURL)
  }
}

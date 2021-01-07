//
//  TrainerListViewController.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import UIKit

class TrainerListViewController: UIViewController {

    var array: [[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
    }
    
    func loadData(){
        do {
            
            self.array = try JSONReader().decodeJsonToObjectDictionary(jsonName: "trainers")
            
            
        } catch {
            
            self.array = nil
            
        }
        
        print("\(self.array ?? [])")
    }
}

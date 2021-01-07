//
//  JSONReader.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import Foundation

class JSONReader {
    
    enum Error: Swift.Error {
        case missingFile(String)
    }
    
    func decodeJsonToObjectDictionary(jsonName: String) throws -> [[String:Any]] {
        
        guard let path = Bundle.main.path(forResource: jsonName, ofType: "json"),
            
            let data = try? Data(contentsOf: URL.init(fileURLWithPath: path)) else {
                
                throw Error.missingFile(jsonName + ".json")
        }
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            
            return json ?? [[String:Any]]()
            
        } catch {
            
            throw error
            
        }
    }
}

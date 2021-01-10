//
//  JSONReader.swift
//  Interview - Internship
//
//  Created by Alessio Sardella on 05/03/2019.
//  Copyright © 2019 Lepaya. All rights reserved.
//

import Foundation

final class JSONReader {
  
  enum Error: Swift.Error {
    case missingFile(String)
    case unableToDecode(Swift.Error)
  }
  
  func decodeJsonToObject<T: Decodable>(jsonName: String) throws -> T {
    guard let path = Bundle.main.path(forResource: jsonName, ofType: "json"),
          let data = try? Data(contentsOf: URL.init(fileURLWithPath: path)) else {
      throw Error.missingFile(jsonName + ".json")
    }
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw Error.unableToDecode(error)
    }
  }
}

//
//  Bundle+Extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Bundle {
    static func readRawjSONData(filename: String, ext: String) -> Data{
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            fatalError("resource with filename \(filename) not found")
        }
        
        var data: Data!
        do{
            data = try Data.init(contentsOf: fileURL)
        }catch{
            fatalError("contents were not found \(error)")
        }
        
        return data
    }
}

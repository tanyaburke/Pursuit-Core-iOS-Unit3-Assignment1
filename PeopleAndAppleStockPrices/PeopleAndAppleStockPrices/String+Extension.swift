//
//  StringExtension.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func convertDateStringtoString() -> String {
        let someFormatter = DateFormatter()
        someFormatter.dateFormat = "yyyy-MM-dd"
        
        let someDate = someFormatter.date(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM - YYYY"
        
        let otherDateString = dateFormatter.string(from: someDate ?? Date())
        return otherDateString
    }
}

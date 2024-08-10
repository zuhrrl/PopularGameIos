//
//  Utils.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import Foundation

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

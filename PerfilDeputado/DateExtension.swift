//
//  DateExtension.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 07/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import Foundation

let calendar = Calendar.current

extension Date {
    func startOfMonth() -> Date {
        var datecomponents = calendar.dateComponents([.year, .month], from: self)
        let range = calendar.range(of: .day, in: .month, for: self)
        datecomponents.day = range?.lowerBound
        return calendar.date(from: datecomponents)!
    }
    
    func endOfMonth() -> Date {
        var datecomponents = calendar.dateComponents([.year, .month], from: self)
        let range = calendar.range(of: .day, in: .month, for: self)
        datecomponents.day = (range?.upperBound)! - 1
        return calendar.date(from: datecomponents)!
    }
}

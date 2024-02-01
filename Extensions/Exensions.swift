//
//  File.swift
//  
//
//  Created by Adit Chakraborty on 01/02/2024.
//

import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday! - 1
    }
}

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
    
    func localizedTimeString() -> String? {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            case 6..<12: return "Morning"
            case 12..<17: return "Afternoon"
            case 17..<22: return "Evening"
            default: return nil
        }
    }
}

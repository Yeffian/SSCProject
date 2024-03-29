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
    
    func localizedTimeString() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 6 && hour < 12 {
            return "Morning"
        } else if hour >= 12 && hour < 18 {
            return "Afternoon"
        } else {
            return "Evening"
        }
    }
}

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "Application_HasBeenLaunchedBefore"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}

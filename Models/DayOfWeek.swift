//
//  DayOfWeek.swift
//  
//
//  Created by Adit Chakraborty on 18/01/2024.
//

import Foundation

enum DayOfWeek {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

func dayFromNumber(number: Int) -> DayOfWeek? {
    switch number {
    case 0:
        return .sunday
    case 1:
        return .monday
    case 2:
        return .tuesday
    case 3:
        return .wednesday
    case 4:
        return .thursday
    case 5:
        return .friday
    case 6:
        return .saturday
    default:
        return nil
    }
}

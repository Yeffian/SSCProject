//
//  DayOfWeek.swift
//  
//
//  Created by Adit Chakraborty on 18/01/2024.
//

import Foundation

enum DayOfWeek: String, CaseIterable, Hashable, Equatable, Codable {
    case sunday = "Sunday",
         monday = "Monday",	
         tuesday = "Tuesday",
         wednesday = "Wednesday",
         thursday = "Thursday",
         friday = "Friday",
         saturday = "Saturday"
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

func numberFromDay(day: DayOfWeek) -> Int {
    switch day {
    case .sunday:
        return 0
    case .monday:
        return 1
    case.tuesday:
        return 2
    case .wednesday:
        return 3
    case .thursday:
        return 4
    case .friday:
        return 5
    case .saturday:
        return 6
    }
}

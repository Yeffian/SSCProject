//
//  Event.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import Foundation

class Event: Identifiable {
    let id: UUID = UUID()
    let day: DayOfWeek
    let eventName: String
    let remainder: String
    let location: String
    let notes: [String]
    let referenceImages: [String]
    let date: Date
    // TODO: Add contacts as callable numbers
    // TODO: Mark contacts as medical vs personal
    
    init(day: DayOfWeek, eventName: String, remainder: String, location: String, notes: [String],
         referenceImages: [String], date: Date = .now) {
        self.day = day
        self.eventName = eventName
        self.remainder = remainder
        self.location = location
        self.notes = notes
        self.referenceImages = referenceImages
        self.date = date
    }
}

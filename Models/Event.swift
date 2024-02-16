//
//  Event.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import Foundation
import PhotosUI
import SwiftData

@Model
class Event: Identifiable {
    let id: UUID = UUID()
    let day: DayOfWeek
    @Attribute(.unique) let eventName: String
    let remainder: String
    let location: String
    let notes: [String]
    let referenceImages: [Data?]
    let date: Date
    // TODO: Add contacts as callable numbers
    // TODO: Mark contacts as medical vs personal
    
    init(day: DayOfWeek, eventName: String, remainder: String, location: String, notes: [String],
         referenceImages: [Data?] = [], date: Date = .now) {
        self.day = day
        self.eventName = eventName
        self.remainder = remainder
        self.location = location
        self.notes = notes
        self.referenceImages = referenceImages
        self.date = date
    }
    
    func getEventStatus() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.minute, from: Date())
        let currentDay = Date().dayNumberOfWeek()
        
        let day = self.date
        let hour = Calendar.current.component(.hour, from: self.date)
        let minute = Calendar.current.component(.minute, from: self.date)
        
        if (Date.now >= self.date && currentDay == day.dayNumberOfWeek()) {
            return "Done"
        } else {
            return "Upcoming"   
        }
    }
}



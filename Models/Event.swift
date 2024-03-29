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
        let currentDay = Date().dayNumberOfWeek()
        
        let time = self.date
                
        if (Date.now >= time && currentDay == time.dayNumberOfWeek()) {
            return "Done"
        } else {
            return "Upcoming"   
        }
    }
}

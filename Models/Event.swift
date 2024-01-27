//
//  Event.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import Foundation
import PhotosUI


class Event: Identifiable {
    var id: UUID = UUID()
    var day: DayOfWeek
    var eventName: String
    var remainder: String
    var location: String
    var notes: [String]
    var referenceImages: [UIImage] = []
    var date: Date
    // TODO: Add contacts as callable numbers
    // TODO: Mark contacts as medical vs personal
    
    init(day: DayOfWeek, eventName: String, remainder: String, location: String, notes: [String],
             referenceImages: [UIImage] = [], date: Date = .now) {
            self.day = day
            self.eventName = eventName
            self.remainder = remainder
            self.location = location
            self.notes = notes
            self.referenceImages = referenceImages
            self.date = date
    }
}

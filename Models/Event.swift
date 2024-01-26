//
//  Event.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import Foundation
import PhotosUI

class Event: Identifiable, Codable {
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
    
    private enum EventCodingKeys: String, CodingKey {
        case id
        case day
        case eventName
        case remainder
        case location
        case notes
        case referenceImages
        case date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EventCodingKeys.self)
        day = try container.decode(DayOfWeek.self, forKey: .day)
        eventName = try container.decode(String.self, forKey: .eventName)
        remainder = try container.decode(String.self, forKey: .remainder)
        location = try container.decode(String.self, forKey: .location)
        notes = try container.decode([String].self, forKey: .notes)
        date = try container.decode(Date.self, forKey: .date)
        
        for referenceImage in try container.decode([String].self, forKey: .referenceImages) {
            self.referenceImages.append(referenceImage.imageFromBase64!)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EventCodingKeys.self)
        try container.encode(day, forKey: .day)
        try container.encode(eventName, forKey: .eventName)
        try container.encode(remainder, forKey: .remainder)
        try container.encode(location, forKey: .location)
        try container.encode(notes, forKey: .notes)
        try container.encode(date, forKey: .date)
        
        var images: [String] = []
        for referenceImage in referenceImages {
            images.append(referenceImage.base64!)
        }
        
        try container.encode(images, forKey: .remainder)
    }
    
}

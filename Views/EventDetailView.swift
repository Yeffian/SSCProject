//
//  EventDetailView.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import SwiftUI

struct EventDetailView: View {
    @State var event: Event
    
    var body: some View {
        List {
            Section(header: Text("Basic Information")) {
                Text(event.remainder)
                Text(event.date, format: .dateTime.hour().minute())
            }
            
            Section(header: Text("Remainders")) {
                Text(event.location)
                Text(event.notes)
            }
            
            Section(header: Text("Images")) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 50) {
                        ForEach(event.referenceImages, id: \.self) { image in
                            Image(image)
                                .frame(width: 750)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EventDetailView(event: Event(eventName: "Test event", remainder: "This is a test event", location: "Adit's room", notes: "This is a note", referenceImages: ["refimg1", "refimg2"]))
}

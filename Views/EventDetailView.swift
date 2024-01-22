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
            Section(header: Text("Information")) {
                HStack {
                    Text("Location")
                    Spacer()
                    Text(event.location)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Time")
                    Spacer()
                    Text(event.date, format: .dateTime.hour().minute())
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Task")
                    Spacer()
                    Text(event.remainder)
                        .fontWeight(.bold)
                }
                
                
                // TODO: Add contacts and contact view
            }
            
            Section(header: Text("Notes")) {
                ForEach(event.notes, id: \.self) { note in
                    Text(note)
                }
            }
            
            Section(header: Text("Images")) {
                TabView {
                    ForEach(event.referenceImages, id: \.self) { referenceImage in
                        Image(uiImage: referenceImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 520)
            }
        }
        .navigationTitle(event.eventName)
    }
}

#Preview {
    EventDetailView(event: Event(day: .thursday, eventName: "Test event", remainder: "This is a test event", location: "Adit's room", notes: ["This is a note"]))
}

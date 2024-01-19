//
//  ScheduleView.swift
//  
//
//  Created by Adit Chakraborty on 19/01/2024.
//

import SwiftUI

struct ScheduleView: View {
    var day: DayOfWeek
    var tasks: [Event]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterByDays(targetDay: day, events: tasks)) { task in
                    NavigationLink {
                        EventDetailView(event: task)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(task.eventName)")
                                .font(.title2)
                            Text(task.date, format: .dateTime.hour().minute())
                                .italic()
                                .font(.footnote)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Good Morning!")
            
            
            EventDetailView(event: filterByDays(targetDay: day, events: tasks)[0])
        }
    }
}

func filterByDays(targetDay: DayOfWeek, events: [Event]) -> [Event] {
    return events.filter { $0.day == targetDay }
}

#Preview {
    ScheduleView(day: .friday, tasks: [])
}

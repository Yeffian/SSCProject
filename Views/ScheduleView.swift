//
//  ScheduleView.swift
//  
//
//  Created by Adit Chakraborty on 19/01/2024.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var information: UserInformation
    @State private var isShowingTaskAddView = false
    var day: DayOfWeek
    var tasks: [Event]
    
    @State var eventName: String = "";
    @State var remainder: String = "";
    @State var location: String = "";
    @State var notesBuffer: String = ""
    @State var notes: [String] = []
    @State var referenceImagesBuffer: String = ""
    @State var referenceImages: [String] = []
    @State var eventDay: Int = -1;
    @State var eventDate: Date = Date.now
    
    var modalView: some View {
        NavigationView {
            Form {
                TextField("What is the name of the event?", text: $eventName)
            }
            .navigationTitle("Create a new event..")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterByDays(targetDay: day, events: information.tasks)) { task in
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
                
                HStack {
                    Spacer()
                    Button {
                        print("Adding a new item to day \(day)")
                        isShowingTaskAddView.toggle()
                    } label: {
                        Text("Add new item..")
                    }
                    .sheet(isPresented: $isShowingTaskAddView, content: {
                        modalView
                    })
                    
                    Spacer()
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

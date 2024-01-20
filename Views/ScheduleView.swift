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
                Section(header: Text("Basic Information")) {
                    TextField("What is the name of the event?", text: $eventName)
                    TextField("What do you need to do?", text: $remainder)
                    TextField("Where do you need to go to do this event?", text: $location)
                    Picker("What day is the event on?", selection: $eventDay) {
                        ForEach([0, 1, 2, 3, 4, 5, 6], id: \.self) { item in
                            Text(dayFromNumber(number: item)?.rawValue ?? "nil")
                                .tag(item)
                        }
                    }
                }
                
                Section(header: Text("Notes and Images")) {
                    TextField("Do you need to leave any notes?", text: $notesBuffer)
                }
            }
            .navigationTitle("Create a new event..")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Create", action: {
                        notes = notesBuffer.components(separatedBy: ",")
                        for note in notes {
                            print(note)
                        }
                    })
                }
            }
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

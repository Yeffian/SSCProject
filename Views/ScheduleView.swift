//
//  ScheduleView.swift
//  
//
//  Created by Adit Chakraborty on 19/01/2024.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
struct ScheduleView: View {
    @EnvironmentObject var information: UserInformation
    @State private var isShowingTaskAddView = false
    @State private var photosPickerItems: [PhotosPickerItem] = []
    var day: DayOfWeek
    var tasks: [Event]
    
    @State var eventName: String = "";
    @State var remainder: String = "";
    @State var location: String = "";
    @State var notesBuffer: String = ""
    @State var notes: [String] = []
    @State var referenceImages: [UIImage] = []
    @State var eventDate: Date = Date.now
    
    var body: some View {
        NavigationView {
            List {
                if (filterByDays(targetDay: day, events: information.tasks).count > 0) {
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
                } else {
                    Text("No events added so far.")
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
                    .onChange(of: isShowingTaskAddView) {
                        if (isShowingTaskAddView == false) {
                            eventName = "";
                            remainder = "";
                            location = "";
                            notesBuffer = ""
                            notes = []
                            referenceImages = []
                            eventDate = Date.now
                            photosPickerItems = []
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Good Morning!")
            
            if (tasks.count > 0) {
                EventDetailView(event: filterByDays(targetDay: day, events: tasks)[0])
            } else {
                Text("No events so far.")
            }
            
        }
    }
    
    var modalView: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("What is the name of the event?", text: $eventName)
                    TextField("What do you need to do?", text: $remainder)
                    TextField("Where do you need to go to do this event?", text: $location)

                    DatePicker("What time do you need to do it?", selection: $eventDate, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Notes and Images")) {
                    TextField("Do you need to leave any notes?", text: $notesBuffer)
                    
                    PhotosPicker("Pick some images to help you remember!", selection: $photosPickerItems, maxSelectionCount: 10, selectionBehavior: .default, matching: .images)
                    }
                }
                .navigationTitle("Create a new event..")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Create", action: {
                            Task {
                                notes = notesBuffer.components(separatedBy: ",")

                                for item in photosPickerItems {
                                    if let data = try? await item.loadTransferable(type: Data.self) {
                                        if let image = UIImage(data: data) {
                                            referenceImages.append(image)
                                        }
                                    }
                                }
                                
                                // close the modal
//                                isShowingTaskAddView.toggle()
                            }
                            self.information.tasks.append(Event(day: day, eventName: eventName, remainder: remainder, location: location, notes: notes, referenceImages: referenceImages, date: eventDate))
                            
                            print("Creating an event now..")
                        })
                    }
                }
            }
    }
}

func filterByDays(targetDay: DayOfWeek, events: [Event]) -> [Event] {
    return events.filter { $0.day == targetDay }
}

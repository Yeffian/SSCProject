//
//  ScheduleView.swift
//  
//
//  Created by Adit Chakraborty on 19/01/2024.
//

import SwiftUI
import SwiftData
import PhotosUI
import UserNotifications

struct ScheduleView: View {
    @EnvironmentObject var notifManager: NotificationManager
    @EnvironmentObject var careeInformation: CareeInformation
    
    @Environment(\.modelContext) private var ctx
    
    @State private var isShowingTaskAddView = false
    @State private var isShowingCareeSettingsView = false
    
    @State private var showIncompleteFieldsAlert = false
    @State private var photosPickerItems: [PhotosPickerItem] = []
    var day: DayOfWeek
    var tasks: [Event]
    
    @State var eventName: String = "";
    @State var remainder: String = "";
    @State var location: String = "";
    @State var notesBuffer: String = ""
    @State var notes: [String] = []
    @State var referenceImages: [Data?] = []
    @State var eventDate: Date = Date.now
    
    @State var careeName: String = ""
    
    var Greeting: String {
        if careeInformation.careeName == nil {
            return "Good \(Date().localizedTimeString()!)!"
        } else {
            return "Good \(Date().localizedTimeString()!), \(careeInformation.careeName!)!"
        }
    }
    
    func canCreateEvent() -> Bool {
        if eventName == "" || remainder == "" || location == "" {
            return false
        }
        
        return true
    }
    
    func addEvent() async {
        notes = notesBuffer.components(separatedBy: ",")
        
        for item in photosPickerItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                referenceImages.append(data)
            }
        }
        
        let event = Event(day: day, eventName: eventName, remainder: remainder, location: location, notes: notes, referenceImages: referenceImages, date: eventDate)
        ctx.insert(event)
        
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: event.date)
        let notification = Notification(identifier: UUID().uuidString,
                                        title: event.eventName,
                                        body: event.remainder,
                                        dateComponents: dateComponents,
                                        repeats: true)
        
        await notifManager.schedule(notification: notification)
        try? ctx.save()
    }
    
    func clearEventData() {
        eventName = "";
        remainder = "";
        location = "";
        notesBuffer = ""
        notes = []
        referenceImages = []
        eventDate = Date.now
        photosPickerItems = []
    }
    
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            ctx.delete(task)
        }
        
        try? ctx.save()
    }
    
    var body: some View {
        NavigationView {
            List {
                if (filterByDays(targetDay: day, events: tasks).count > 0) {
                    ForEach(filterByDays(targetDay: day, events: tasks)) { task in
                        NavigationLink {
                            EventDetailView(event: task)
                        } label: {
                            HStack {
                                Text(task.getEventStatus() == "Upcoming" ? "⏱️" : "✅")
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
                    .onDelete(perform: deleteTask)
                } else {
                    Text("No events added so far.")
                        .font(.callout)
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
                        eventCreationModal
                    })
                    .onChange(of: isShowingTaskAddView) {
                        if (isShowingTaskAddView == false) {
                            clearEventData()
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle(Greeting)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Settings", action: {
                        isShowingCareeSettingsView.toggle()
                    })
                }
            }
            .sheet(isPresented: $isShowingCareeSettingsView, content: {
                NavigationView {
                    Form {
                        TextField("What is the name of the caree?", text: $careeName)
                    }
                    .navigationTitle("Caree Information")
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button("Update", action: {
                                Task {
                                    careeInformation.careeName = careeName
                                }
                            })
                            
                            Button("Cancel", action: {
                                isShowingCareeSettingsView.toggle()
                            })
                        }
                    }
                }
            })
            
            if (!filterByDays(targetDay: day, events: tasks).isEmpty) {
                EventDetailView(event: filterByDays(targetDay: day, events: tasks)[0])
            } else {
                Text("Create a task from the sidebar to get started!")
            }
        }
    }
    
    
    var eventCreationModal: some View {
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
                                if canCreateEvent() {
                                    await addEvent()
                                    // close the modal
                                    isShowingTaskAddView.toggle()
                                } else {
                                    showIncompleteFieldsAlert.toggle()
                                }
                            }
                        })
                        
                        Button("Cancel", action: {
                            clearEventData()
                            isShowingTaskAddView.toggle()
                        })
                    }
                }
                .alert("Please fill in all the mandatory fields.", isPresented: $showIncompleteFieldsAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
    }
}

func filterByDays(targetDay: DayOfWeek, events: [Event]) -> [Event] {
    return events.filter { $0.day == targetDay }
}

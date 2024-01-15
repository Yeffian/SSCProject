import SwiftUI

struct ContentView: View {
    let tasks = [
        Event(eventName: "Eat breakfast", remainder: "Make sure to eat breakfast!", location: "Dining Room", notes: ["Don't eat anything to oily", "Get a glass of water before sitting down"], referenceImages: ["dining_table 1", "dining_table 1"], date: CreateDate(hour: 7, minute: 30)),
        Event(eventName: "Take breakfast meds", remainder: "Take your meds after breakfast", location: "Dining Room", notes: ["Eat the meds marked 'morning'"], referenceImages: ["medicine_box", "dining_table 1"], date: CreateDate(hour: 7, minute: 40)),
        Event(eventName: "Eat lunch", remainder: "Make sure to eat lunch", location: "Dining Table", notes: ["Get a glass of water before sitting down in case you cough", "Be careful while eating fish"], referenceImages: ["dining_table 1", "dining_table 1"], date: CreateDate(hour: 14, minute: 30)),
        Event(eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: CreateDate(hour: 14, minute: 40)),
        
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
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
            }
            
            EventDetailView(event: tasks[0])
            
        }
    }
}

func CreateDate(hour: Int, minute: Int, seconds: Int = 0) -> Date {
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.second = seconds
    let calendar = Calendar.current
    let date = calendar.date(from: components)
    return date ?? .now
}

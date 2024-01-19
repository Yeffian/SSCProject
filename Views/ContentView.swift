import SwiftUI

struct ContentView: View {
    let tasks = [
        Event(day: .monday, eventName: "Eat breakfast", remainder: "Make sure to eat breakfast!", location: "Dining Room", notes: ["Don't eat anything to oily", "Get a glass of water before sitting down"], referenceImages: ["dining_table 1", "dining_table 1"], date: createDate(hour: 7, minute: 30)),
        Event(day: .tuesday, eventName: "Take breakfast meds", remainder: "Take your meds after breakfast", location: "Dining Room", notes: ["Eat the meds marked 'morning'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 7, minute: 40)),
        Event(day: .wednesday, eventName: "Eat lunch", remainder: "Make sure to eat lunch", location: "Dining Table", notes: ["Get a glass of water before sitting down in case you cough", "Be careful while eating fish"], referenceImages: ["dining_table 1", "dining_table 1"], date: createDate(hour: 14, minute: 30)),
        Event(day: .thursday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
        Event(day: .friday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
        Event(day: .saturday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
        Event(day: .sunday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
    ]
    
    @State var day: DayOfWeek
    
    var body: some View {
        TabView {
            ScheduleView(day: .sunday, tasks: tasks)
            .tabItem {
                Text("Sun")
            }
            
            ScheduleView(day: .monday, tasks: tasks)
            .tabItem {
                Text("Mon")
            }
            
            ScheduleView(day: .tuesday, tasks: tasks)
            .tabItem {
                Text("Tues")
            }
            
            ScheduleView(day: .wednesday, tasks: tasks)
            .tabItem {
                Text("Wed")
            }
            
            ScheduleView(day: .friday, tasks: tasks)
            .tabItem {
                Text("Fri")
            }
            
            ScheduleView(day: .saturday, tasks: tasks)
            .tabItem {
                Text("Sat")
            }
        }
    }
}

func createDate(hour: Int, minute: Int, seconds: Int = 0) -> Date {
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.second = seconds
    let calendar = Calendar.current
    let date = calendar.date(from: components)
    return date ?? .now
}

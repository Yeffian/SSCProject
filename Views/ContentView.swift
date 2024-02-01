import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ContentView: View {
//    @EnvironmentObject var information: UserInformation
    @Environment(\.modelContext) private var ctx
    @Query private var tasks: [Event]
    
    @State var day: Int
    
    var body: some View {
        TabView(selection: $day) {
            ScheduleView(day: .sunday, tasks: tasks)
            .tabItem {
                Text("Sun")
            }
            .tag(0)
            
            ScheduleView(day: .monday, tasks: tasks)
            .tabItem {
                Text("Mon")
            }
            .tag(1)
            
            ScheduleView(day: .tuesday, tasks: tasks)
            .tabItem {
                Text("Tues")
            }
            .tag(2)
            
            ScheduleView(day: .wednesday, tasks: tasks)
            .tabItem {
                Text("Wed")
            }
            .tag(3)
            
            ScheduleView(day: .thursday, tasks: tasks)
            .tabItem {
                Text("Thurs")
            }
            .tag(4)
            
            ScheduleView(day: .friday, tasks: tasks)
            .tabItem {
                Text("Fri")
            }
            .tag(5)
            
            ScheduleView(day: .saturday, tasks: tasks)
            .tabItem {
                Text("Sat")
            }
            .tag(6)
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

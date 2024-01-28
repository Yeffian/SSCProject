import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ContentView: View {
//    @EnvironmentObject var information: UserInformation
    @Environment(\.modelContext) private var ctx
    @Query private var tasks: [Event]
    
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
            
            ScheduleView(day: .thursday, tasks: tasks)
            .tabItem {
                Text("Thurs")
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

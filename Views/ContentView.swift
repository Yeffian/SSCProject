import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var information: UserInformation
    
    @State var day: DayOfWeek
    
    var body: some View {
        TabView {
            ScheduleView(day: .sunday, tasks: information.tasks)
            .tabItem {
                Text("Sun")
            }
            
            ScheduleView(day: .monday, tasks: information.tasks)
            .tabItem {
                Text("Mon")
            }
            
            ScheduleView(day: .tuesday, tasks: information.tasks)
            .tabItem {
                Text("Tues")
            }
            
            ScheduleView(day: .wednesday, tasks: information.tasks)
            .tabItem {
                Text("Wed")
            }
            
            ScheduleView(day: .thursday, tasks: information.tasks)
            .tabItem {
                Text("Thursday")
            }
            
            ScheduleView(day: .friday, tasks: information.tasks)
            .tabItem {
                Text("Fri")
            }
            
            ScheduleView(day: .saturday, tasks: information.tasks)
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

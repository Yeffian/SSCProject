import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var notifManager: NotificationManager
    @Environment(\.modelContext) private var ctx
    @Environment(\.scenePhase) private var scenePhase
    
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
        .task {
            // Request authorization to send notifications
            try? await notifManager.requestAuthorization()
        }
    }
}

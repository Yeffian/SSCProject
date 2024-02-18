import SwiftUI
import SwiftData
import WelcomeSheet

struct ContentView: View {
    @EnvironmentObject var notifManager: NotificationManager
    @Environment(\.modelContext) private var ctx
    @Environment(\.scenePhase) private var scenePhase
    
    @Query private var tasks: [Event]
    
    @State var day: Int
    @State var showPage = true
    
    let pages = [
        WelcomeSheetPage(title: "Welcome to SSC Project!", rows: [
            WelcomeSheetPageRow(imageSystemName: "bolt.horizontal.circle",
                                            title: "Easy to Use",
                                            content: "With relatively simple UI, the app is made with navigation as a priority, so that anyone can use it, no matter their tech-saviness."),
                        
                        WelcomeSheetPageRow(imageSystemName: "waveform.path.ecg",
                                            title: "Designed for Memory",
                                            content: "Using images and sending notifications when it is time, we try our best to ensure the caree will not forget when, where or what to do."),
                        
                        WelcomeSheetPageRow(imageSystemName: "person.2.square.stack",
                                            title: "Works for Anyone",
                                            content: "No matter if you are using it yourself to keep on track, or it is for an older family member or others who struggle to remember things, the app holds no bias in who it serves.")
        ])
    ]
    
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
        .welcomeSheet(isPresented: $showPage, pages: pages)
    }
}

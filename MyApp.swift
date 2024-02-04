import SwiftUI
import SwiftData
import Foundation

@main
struct MyApp: App {
    @StateObject var notifManager = NotificationManager()
    @StateObject var careeInformation = CareeInformation()
    
    var body: some Scene {
        WindowGroup {
            ContentView(day: Date().dayNumberOfWeek()!)
        }
        .modelContainer(for: [Event.self])
        .environmentObject(notifManager)
        .environmentObject(careeInformation)
    }
}

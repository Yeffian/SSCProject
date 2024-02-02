import SwiftUI
import SwiftData
import Foundation

@main
struct MyApp: App {
    @StateObject var notifManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            ContentView(day: Date().dayNumberOfWeek()!)
        }
        .modelContainer(for: [Event.self])
        .environmentObject(notifManager)
    }
}

import SwiftUI
import SwiftData
import Foundation

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(day: Date().dayNumberOfWeek()!)
        }
        .modelContainer(for: [Event.self])
    }
}

import SwiftUI
import SwiftData
import Foundation

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            /* TODO: Make the TabView highlight on the current day. */
            ContentView(day: dayFromNumber(number: Calendar.current.component(.year, from: Date())) ?? .monday)
        }
        .modelContainer(for: [Event.self])
    }
}

import SwiftUI
import SwiftData
import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday! - 1
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            /* TODO: Make the TabView highlight on the current day. */
            ContentView(day: Date().dayNumberOfWeek()!)
        }
        .modelContainer(for: [Event.self])
    }
}

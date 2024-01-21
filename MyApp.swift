import SwiftUI
import Foundation

@available(iOS 17.0, *)
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            /* TODO: Make the TabView highlight on the current day. */
            ContentView(day: dayFromNumber(number: Calendar.current.component(.year, from: Date())) ?? .monday)
                .environmentObject(UserInformation(tasks: [
                    Event(day: .monday, eventName: "Eat breakfast", remainder: "Make sure to eat breakfast!", location: "Dining Room", notes: ["Don't eat anything to oily", "Get a glass of water before sitting down"], referenceImages: ["dining_table 1", "dining_table 1"], date: createDate(hour: 7, minute: 30)),
                    Event(day: .tuesday, eventName: "Take breakfast meds", remainder: "Take your meds after breakfast", location: "Dining Room", notes: ["Eat the meds marked 'morning'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 7, minute: 40)),
                    Event(day: .wednesday, eventName: "Eat lunch", remainder: "Make sure to eat lunch", location: "Dining Table", notes: ["Get a glass of water before sitting down in case you cough", "Be careful while eating fish"], referenceImages: ["dining_table 1", "dining_table 1"], date: createDate(hour: 14, minute: 30)),
                    Event(day: .thursday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
                    Event(day: .friday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
                    Event(day: .saturday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
                    Event(day: .sunday, eventName: "Take lunch meds", remainder: "Take your meds after lunch", location: "Dining Room", notes: ["Eat the meds marked 'afternoon'"], referenceImages: ["medicine_box", "dining_table 1"], date: createDate(hour: 14, minute: 40)),
                ]))
        }
    }
}

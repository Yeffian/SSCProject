//
//  NotificationManager.swift
//  SSCProject
//
//  Created by Adit Chakraborty on 02/02/2024.
//

import Foundation
import NotificationCenter

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    
    @Published var pendingRequests: [UNNotificationRequest] = []
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    // Delegate function
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        await getPendingRequests()
        return [.sound, .banner]
    }
    
    func requestAuthorization() async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
    }
    
    func schedule(notification: Notification) async {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = .default
        
        if notification.scheduleType == .time {
            guard let timeInterval = notification.timeInterval else { return }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: notification.repeats)
            let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
            
            try? await notificationCenter.add(request)
        } else {
            guard let dateComponents = notification.dateComponents else { return }
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: notification.repeats)
            let request = UNNotificationRequest(identifier: notification.identifier, content: content, trigger: trigger)
            
            try? await notificationCenter.add(request)
        }
        
        await getPendingRequests()
    }
    
    func getPendingRequests() async {
        pendingRequests = await notificationCenter.pendingNotificationRequests()
        print("Pending: \(pendingRequests.count)")
    }
}

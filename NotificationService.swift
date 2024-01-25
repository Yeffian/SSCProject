//
//  NotificationService.swift
//  SSCProject
//
//  Created by Adit Chakraborty on 25/01/2024.
//

import Foundation
import UserNotifications

class NotificationService {
    func askForPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification permissions granted.")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func sendNotification() {
        
    }
}

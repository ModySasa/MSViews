//
//  SystemNotificationManager.swift
//  MSViews
//
//  Created by Moha on 11/3/25.
//

import UserNotifications

final public class SystemNotificationManager {
    // MARK: - Singleton instance
    public static let shared = SystemNotificationManager()
    private init() {}
    
    // MARK: - Request permission
    public func requestPermissionIfNeeded() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .notDetermined else { return }
            
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                } else {
                    print(granted ? "✅ Notification permission granted." : "❌ Permission denied.")
                }
            }
        }
    }
    
    // MARK: - Schedule notification
    public func showNotification(
        title: String,
        body: String,
        sound: UNNotificationSound = .default,
        after delay: TimeInterval = 1
    ) {
        let center = UNUserNotificationCenter.current()
        
        // Check current authorization state
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("⚠️ Notifications are not authorized.")
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = sound
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("❌ Error showing notification: \(error.localizedDescription)")
                } else {
                    print("✅ Notification scheduled: \(title)")
                }
            }
        }
    }
}

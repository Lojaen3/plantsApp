//
//  NotificationManager.swift
//  plants
//
//  Created by Lojaen Jehad Ayash on 04/05/1447 AH.
//

import UserNotifications
import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    // ✅ Request notification permission
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification permission error: \(error.localizedDescription)")
            } else {
                print(granted ? "✅ Notification permission granted" : "⚠️ Notification permission denied")
            }
        }
    }

    // 🧹 Remove notifications for specific plants
    func clearNotifications(for plants: [Plant]) {
        let ids = plants.map { "waterPlantReminder_\($0.id)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
        print("🧹 Cleared notifications for plants: \(ids)")
    }


    // 🕙 Schedule daily notifications for plants at 10:00 AM
    func scheduleNotifications(for plants: [Plant]) {
        // إزالة إشعارات النباتات الحالية قبل إعادة الجدولة
        clearNotifications(for: plants)
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0

        // 🧠 If there are NO plants, send "Add new plant" notification
        if plants.isEmpty {
            let addPlantContent = UNMutableNotificationContent()
            addPlantContent.title = "Planto"
            addPlantContent.body = "Time to add a new plant! 🌱"
            addPlantContent.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let addRequest = UNNotificationRequest(
                identifier: "addPlantReminder_general",
                content: addPlantContent,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(addRequest)
            print("✅ Scheduled 'Add Plant' notification (no plants yet)")
            return
        }

        // 💧 Otherwise, schedule one water reminder per plant
        for plant in plants {
            let content = UNMutableNotificationContent()
            content.title = "\(plant.name) is thirsty!"
            content.body = "💧 Don't forget to water \(plant.name)"
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: "waterPlantReminder_\(plant.id)",
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Error scheduling notification for \(plant.name): \(error.localizedDescription)")
                } else {
                    print("✅ Scheduled water reminder for \(plant.name)")
                }
            }
        }
    }
}

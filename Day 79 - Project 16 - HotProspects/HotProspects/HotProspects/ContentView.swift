//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button("Request Permittion") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .buttonStyle(.bordered)
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Water your plants!"
                content.subtitle = "They look thirsty"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}

//
//  InterfaceController.swift
//  NotificacaoPoc Watch App
//
//  Created by Ana Raiany Guimarães Gomes on 2023-06-12.
//

import WatchKit
import Foundation
import UserNotifications

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var progressBar: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        startProgressBar()
    }
    
    func startProgressBar() {
        var progress: Float = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += 0.1
            self.progressBar.setImageNamed("progress\(Int(progress * 10))")
            
            if progress >= 1.0 {
                timer.invalidate()
                self.sendCompletionNotification()
            }
        }
    }
    
    func sendCompletionNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "TAREFA COMPLETA"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "TaskComplete", content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("Erro ao enviar a notificação: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}


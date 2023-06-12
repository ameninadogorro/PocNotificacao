//
//  ContentView.swift
//  NotificacaoPoc Watch App
//
//  Created by Ana Raiany Guimarães Gomes on 2023-06-12.
//
import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var progress: Float = 0.0
    
    var body: some View {
        VStack {
            Text("Progresso")
                .font(.headline)
                .padding()
            
            ProgressView(value: progress)
                .padding()
            
            Button(action: {
                startProgressBar()
            }) {
                Text("Iniciar")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    func startProgressBar() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += 0.1
            
            if progress >= 1.0 {
                progress = 0
                timer.invalidate()
                sendCompletionNotification()
            }
        }
    }
    
    func sendCompletionNotification() {
        print("sendCompletionNotification")
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                
                print("autorizado")
                
                let content = UNMutableNotificationContent()
                content.title = "TAREFA COMPLETA"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "TaskComplete", content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("Erro ao enviar a notificação: \(error.localizedDescription)")
                    } else {
                        print("enviado")
                    }
                }
            } else {
                print("nao autorizado")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SocketIOManager.swift
//  HelloChat
//
//  Created by KIM MIMI on 9/3/24.
//

import Foundation
import SocketIO

class SocketIOManager: ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    @Published var isConnected = false
    @Published var messages: [ChatMessage] = []
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        
        addHandlers()
        
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    
    private func addHandlers() {
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket connected")
        }
        
        socket.on("message") { [weak self] data, ack in
            guard let self = self else { return }
            
            if let messageData = data[0] as? [String: Any],
               let content = messageData["content"] as? String {
                let message = ChatMessage(role: .other, message: content)
                messages.append(message)
            }
        }
    }
    
    func sendMessage(content: String) {
        let messageData = ["content": content]
        messages.append(ChatMessage(role: .me, message: content))
        socket.emit("message", messageData)
    }
}

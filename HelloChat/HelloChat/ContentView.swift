//
//  ContentView.swift
//  HelloChat
//
//  Created by KIM MIMI on 9/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var socketManager = SocketIOManager()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(socketManager.messages) { message in
                        HStack {
                            if message.role == .me {
                                Spacer()
                                Text(message.message)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            } else {
                                Text(message.message)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
            }
            
            HStack {
                TextField("Enter your message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    if !messageText.isEmpty {
                        socketManager.sendMessage(content: messageText)
                        messageText = ""
                    }
                }) {
                    Text("Send")
                        .bold()
                }
                .padding(.trailing)
            }
            .padding(.vertical)
        }
        .onAppear {
            socketManager.connect()
        }
        .onDisappear {
            socketManager.disconnect()
        }
    }
}

#Preview {
    ContentView()
}

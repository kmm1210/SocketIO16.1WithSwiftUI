//
//  HelloChatApp.swift
//  HelloChat
//
//  Created by KIM MIMI on 9/3/24.
//

import SwiftUI

@main
struct HelloChatApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
                
                
            @unknown default:
                print("unexpected Value")
            }
        }
    }
}

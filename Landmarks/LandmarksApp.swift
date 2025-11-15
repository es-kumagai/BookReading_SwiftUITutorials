//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/05.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State static private(set) var modelData = ModelData()

    #if os(watchOS)
    static let userNotificationCategory = "LandmarkNear"
    #endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(Self.modelData)
        }
        #if os(iOS) || os(macOS)
        .commands {
            LandmarksCommands()
        }
        #endif

        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: Self.userNotificationCategory)
        #endif

        #if os(macOS)
        Settings {
            LandmarkSettings()
        }
        #endif
    }
}

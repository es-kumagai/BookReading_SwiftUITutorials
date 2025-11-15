//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by とりあえず読書会 on 2025/10/05.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    var body: some View {
        LandmarkList(showingProfile: $showingProfile)
            .task {
                _ = try? await userNotificationCenter.requestAuthorization(
                    options: [.alert, .sound, .badge]
                )
            }
            .sheet(isPresented: $showingProfile) {
                ProfileSummary(profile: modelData.effectiveProfile)
            }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}

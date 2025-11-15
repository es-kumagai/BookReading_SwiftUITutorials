//
//  ContentView.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/05.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ModelData.self) var modelData
    
    @State private var activeTab = Tab.featured
    @State private var showingProfile = false
    
    var body: some View {
        TabView(selection: $activeTab) {
            tabItem("Featured", systemImage: .star, tag: .featured) {
                CategoryHome(showingProfile: $showingProfile)
            }
            
            tabItem("List", systemImage: .listBullet, tag: .list) {
                LandmarkList(showingProfile: $showingProfile)
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
        }
    }
}

private extension ContentView {
    
    enum Tab {
        case featured
        case list
    }
    
    @ViewBuilder
    func tabItem(_ label: LocalizedStringKey, systemImage: SystemImage, tag: Tab, @ViewBuilder content: () -> some View) -> some View {
        content()
            .tabItem {
                Label(label, systemImage: systemImage)
            }
            .tag(tag)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}

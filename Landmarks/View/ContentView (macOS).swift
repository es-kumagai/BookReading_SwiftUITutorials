//
//  ContentView.swift
//  MacLandmarks
//
//  Created by とりあえず読書会 on 2025/10/12.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false

    var body: some View {
        LandmarkList(showingProfile: $showingProfile)
            .frame(minWidth: 700, minHeight: 300)
            .sheet(isPresented: $showingProfile) {
                VStack {
                    headerView
                    ProfileSummary(profile: modelData.effectiveProfile)
                }
                .padding(20)
            }
    }
}

private extension ContentView {
    
    @ViewBuilder
    var headerView: some View {
        HStack {
            Spacer()
            Button {
                showingProfile = false
            } label: {
                Image(systemImage: .xmark)
            }
            .buttonStyle(.plain)
        }
    }
}
#Preview {
    ContentView()
        .environment(ModelData())
}

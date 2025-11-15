//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/20.
//

import SwiftUI

struct ProfileSummary: View {

    @Environment(ModelData.self) var modelData

    let profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                profileView
                Divider()
                completedBadgesView
                Divider()
                recentHikesView
            }
        }
    }
}

extension ProfileSummary {
    
    @ViewBuilder
    var profileView: some View {
        Text(profile.username)
            .bold()
            .font(.title)
        
        Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
        Text("Seasonal Photos: \(profile.seasonalPhoto.symbol)")
        Text("Goal Date: \(profile.goalDate, style: .date)")
    }
    
    @ViewBuilder
    var completedBadgesView: some View {
        VStack(alignment: .leading) {
            Text("Completed Badges")
                .font(.headline)
            
            ScrollView(.horizontal) {
                HStack {
                    HikeBadge(name: "First Hike")
                    HikeBadge(name: "Earth Day")
                        .hueRotation(Angle(degrees: 90))
                    HikeBadge(name: "Tenth Hike")
                        .grayscale(0.5)
                        .hueRotation(Angle(degrees: 45))
                }
                .padding(.bottom)
            }
        }
    }
    
    @ViewBuilder
    var recentHikesView: some View {
        VStack(alignment: .leading) {
            Text("Recent Hikes")
                .font(.headline)
            
            HikeView(hike: modelData.hikes[0])
        }
    }
}

#Preview {
    ProfileSummary(profile: ModelData.defaultProfile)
        .environment(ModelData())
}

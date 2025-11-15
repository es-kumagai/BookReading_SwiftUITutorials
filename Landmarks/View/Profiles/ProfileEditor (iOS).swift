//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/25.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding private(set) var profile: Profile
    
    var body: some View {
        List {
            usernameRow
            enableNotificationsRow
            seasonalPhotoRow
            goalDateRow
        }
    }
}

private extension ProfileEditor {
    
    var goalDateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let maxDate = calendar.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return minDate...maxDate
    }

    @ViewBuilder
    var usernameRow: some View {
        HStack {
            Text("Username")
            Spacer()
            TextField("Username", text: $profile.username)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
    
    @ViewBuilder
    var enableNotificationsRow: some View {
        Toggle(isOn: $profile.prefersNotifications) {
            Text("Enable Notifications")
        }
    }
    
    @ViewBuilder
    var seasonalPhotoRow: some View {
        Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
            ForEach(Profile.Season.allCases) { season in
                Text(season.symbol).tag(season)
            }
        }
    }
    
    @ViewBuilder
    var goalDateRow: some View {
        DatePicker(selection: $profile.goalDate, in: goalDateRange, displayedComponents: .date) {
            Text("Goal Date")
        }
    }
}

#Preview {
    ProfileEditor(profile: .constant(ModelData.defaultProfile))
}

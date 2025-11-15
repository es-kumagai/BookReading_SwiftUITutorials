//
//  ProfileHost.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/20.
//

import SwiftUI

struct ProfileHost: View {

    @Environment(ModelData.self) var modelData
    @Environment(\.editMode) var editMode

    @State private var pendingProfile: Profile?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            buttonsArea
            contentArea
        }
        .padding()
    }
}

private extension ProfileHost {
    
    var editingProfile: Binding<Profile> {
        Binding(
            get: { pendingProfile ?? presentProfile },
            set: { pendingProfile = $0 }
        )
    }
    
    var presentProfile: Profile {
        get {
            modelData.effectiveProfile
        }
        
        nonmutating set (newProfile) {
            modelData.effectiveProfile = newProfile
        }
    }

    var isEditing: Bool {
        get {
            editMode?.wrappedValue.isEditing ?? false
        }
        
        nonmutating set {
            editMode?.wrappedValue = .inactive
        }
    }
    
    @ViewBuilder
    var buttonsArea: some View {
        HStack {
            if isEditing {
                Button("Cancel", role: .cancel) {
                    pendingProfile = nil
                    isEditing = false
                }
            }
            Spacer()
            EditButton()
        }
    }
    
    @ViewBuilder
    var contentArea: some View {
        switch isEditing {
        case true:
            ProfileEditor(profile: editingProfile)
                    
        case false:
            ProfileSummary(profile: presentProfile)
                .onAppear {
                    if let newProfile = pendingProfile {
                        presentProfile = newProfile
                        pendingProfile = nil
                    }
                }
        }
    }
}

#Preview {
    ProfileHost()
        .environment(ModelData())
}

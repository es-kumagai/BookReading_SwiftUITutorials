//
//  ProfileToolbar.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/24.
//

import SwiftUI

struct ProfileToolbar: ViewModifier {
    
    @Binding private(set) var showingProfile: Bool
    
    func body(content: Content) -> some View {
        content.toolbar {
            Button {
                showingProfile = true
            } label: {
                Label("User Profile", systemImage: .personCropCircle)
            }
        }
    }
}

extension View {
    
    func profileToolbar(_ showingProfile: Binding<Bool>) -> some View {
        modifier(ProfileToolbar(showingProfile: showingProfile))
    }
}

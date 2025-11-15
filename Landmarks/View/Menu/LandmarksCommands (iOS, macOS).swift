//
//  LandmarksCommands.swift
//  Landmarks for iOS
//
//  Created by とりあえず読書会 on 2025/10/19.
//

import SwiftUI

struct LandmarksCommands: Commands {
    
    @FocusedBinding(\.selectedLandmark) var selectedLandmark
    
    var body: some Commands {
        SidebarCommands()
        
        CommandMenu("Landmark") {
            if let landmark = Binding($selectedLandmark) {
                FavoriteMenuItem(landmark: landmark)
            }
        }
    }
}

private extension LandmarksCommands {
        
    struct FavoriteMenuItem: View {
        
        @Binding private(set) var landmark: Landmark
        
        var title: String {
            landmark.isFavorite ? "Remove" : "Mark"
        }
        
        var body: some View {
            Button("\(title) as Favorite") {
                landmark.isFavorite.toggle()
            }
            .keyboardShortcut("f", modifiers: [.shift, .option])
        }
    }
}

private struct SelectedLandmarkKey: FocusedValueKey {
    typealias Value = BindingLandmark
}

extension FocusedValues {
    var selectedLandmark: BindingLandmark? {
        get { self[SelectedLandmarkKey.self] }
        set { self[SelectedLandmarkKey.self] = newValue }
    }
}

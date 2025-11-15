//
//  ShowFavoriteOnlyToggle.swift
//  Landmarks for iOS
//
//  Created by とりあえず読書会 on 2025/10/10.
//

import SwiftUI

struct ShowFavoriteOnlyToggle: View {
    
    @Binding private(set) var showFavoritesOnly: Bool
    
    var body: some View {
        Toggle(isOn: $showFavoritesOnly) {
            Text("Favorites Only")
        }
    }
}

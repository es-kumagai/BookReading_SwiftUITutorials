//
//  ListMenuModifier.swift
//  Landmarks for watchOS
//
//  Created by とりあえず読書会 on 2025/10/10.
//

import SwiftUI

struct ListMenuModifier: ViewModifier {
    
    @Binding private(set) var showingMenu: Bool
    @Binding private(set) var showFavoritesOnly: Bool
    @Binding private(set) var showingProfile: Bool
    
    func body(content: Content) -> some View {
        content
            .onLongPressGesture {
                showingMenu = true
            }
            .confirmationDialog("MENU", isPresented: $showingMenu) {
                Button(showFavoritesOnly ? "Show All" : "Favorite Only") {
                    showFavoritesOnly.toggle()
                }
                Button("User Profile") {
                    showingProfile = true
                }
            }
    }
}

extension View {
    
    func listMenu(showingMenu: Binding<Bool>, showFavoritesOnly: Binding<Bool>, showingProfile: Binding<Bool>) -> some View {
        modifier(ListMenuModifier(showingMenu: showingMenu, showFavoritesOnly: showFavoritesOnly, showingProfile: showingProfile))
    }
}

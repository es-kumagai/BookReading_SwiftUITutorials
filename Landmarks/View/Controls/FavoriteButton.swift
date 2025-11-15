//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/11.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding private(set) var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            StarImage(isActive: isSet)
        }
        .accessibilityLabel("Toggle Favorite")
    }
}

#Preview {
    @Previewable @State var isSet = true
    FavoriteButton(isSet: $isSet)
}

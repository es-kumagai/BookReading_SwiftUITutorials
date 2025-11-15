//
//  CircleImage.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/05.
//

import SwiftUI

struct CircleImage: View {
    
    let image: Landmark.Image
    
    let borderColor: Color
    let borderWidth: Double
    let borderShadowRadius: Double
    
    init(image: Landmark.Image, borderColor: Color = .white, borderWidth: Double = 4, borderShadowRadius: Double = 7) {
        self.image = image
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.borderShadowRadius = borderShadowRadius
    }
    
    var body: some View {
        Image(image)
            .resizable()
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(borderColor, lineWidth: borderWidth)
            }
            .shadow(radius: borderShadowRadius)
    }
}

#Preview {
    let image = Landmark.Image(name: "icybay")
    CircleImage(image: image, borderColor: .yellow)
}

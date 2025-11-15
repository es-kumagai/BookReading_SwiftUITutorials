//
//  FeatureCard.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/09/27.
//

import SwiftUI

struct FeatureCard: View {
    let landmark: Landmark

    var body: some View {
        if let image = Landmark.Image(featureImageOf: landmark) {
            Image(image)
                .resizable()
                .overlay {
                    OverlayText(landmark: landmark)
                }
        }
    }
}

private extension FeatureCard {
    
    struct OverlayText: View {
        let landmark: Landmark
        let color: Color
        
        init(landmark: Landmark, color: Color = .white) {
            self.landmark = landmark
            self.color = color
        }
        
        var background: some View {
            LinearGradient.linearGradient(
                Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .center)
        }
        
        var body: some View {
            ZStack(alignment: .bottomLeading) {
                background
                VStack(alignment: .leading) {
                    Text(landmark.name)
                        .font(.title)
                        .bold()
                    Text(landmark.park)
                }
                .padding()
            }
            .foregroundStyle(color)
        }
    }
}

#Preview {
    FeatureCard(landmark: ModelData().bindingFeaturedLandmarks[0].wrappedValue)
        .aspectRatio(3 / 2, contentMode: .fit)
}

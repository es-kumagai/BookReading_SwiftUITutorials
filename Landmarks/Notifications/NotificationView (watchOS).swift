//
//  NotificationView.swift
//  Landmarks for watchOS
//
//  Created by とりあえず読書会 on 2025/10/07.
//

import SwiftUI

struct NotificationView: View {
    var title: String
    var message: String
    var landmarkImage: Landmark.Image?
    
    init(title: String, message: String, landmarkImage: Landmark.Image? = nil) {
        self.title = title
        self.message = message
        self.landmarkImage = landmarkImage
    }
    
    var body: some View {
        VStack {
            if let landmarkImage {
                CircleImage(image: landmarkImage)
                    .scaledToFit()
            }
            
            Text(title)
                .font(.headline)
            
            Divider()
            
            Text(message)
                .font(.caption)
        }
    }
}

#Preview {
    NotificationView(
        title: "Turtle Rock",
        message: "You are within 5 miles of Turtle Rock.",
        landmarkImage: ModelData().landmarks[0].image
    )
}

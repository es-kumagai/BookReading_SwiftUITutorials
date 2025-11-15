//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/08.
//

import SwiftUI

struct LandmarkDetail: View {
    
    @Binding private(set) var landmark: Landmark
    
    var body: some View {
        ScrollView {
            MapView(coordinates: landmark.coordinates)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            Content(landmark: $landmark)
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension LandmarkDetail {
    
    struct Content: View {
        
        @Binding private(set) var landmark: Landmark
        
        var body: some View {
            VStack(alignment: .leading) {
                Title(landmark: $landmark)
                Divider()
                Description(landmark: landmark)
            }
            .padding()
        }
    }
}

private extension LandmarkDetail.Content {
    
    struct Title: View {
        
        @Binding private(set) var landmark: Landmark
        
        var body: some View {
            header
            subHeader
        }
    }
    
    struct Description: View {
        
        let landmark: Landmark
        
        var body: some View {
            Text("About \(landmark.name)")
                .font(.title2)
            Text(landmark.description)
        }
    }
}

private extension LandmarkDetail.Content.Title {
    
    @ViewBuilder
    var header: some View {
        HStack {
            Text(landmark.name)
                .font(.title)
            
            FavoriteButton(
                isSet: $landmark.isFavorite
            )
        }
    }
    
    @ViewBuilder
    var subHeader: some View {
        HStack {
            Text(landmark.park)
            Spacer()
            Text(landmark.state)
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    LandmarkDetail(landmark: $modelData.landmarks[0])
}

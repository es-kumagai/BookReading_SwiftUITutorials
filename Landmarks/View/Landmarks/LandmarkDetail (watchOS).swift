//
//  LandmarkDetail.swift
//  WatchLandmarks Watch App
//
//  Created by とりあえず読書会 on 2025/10/05.
//

import SwiftUI

struct LandmarkDetail: View {

    @Binding private(set) var landmark: Landmark

    var body: some View {
        ScrollView {
            summaryArea
            Divider()
            mapArea
        }
        .navigationTitle("Landmarks")
    }
}

private extension LandmarkDetail {
    
    @ViewBuilder
    var summaryArea: some View {
        imageArea
        titleArea
        Divider()
        subTitleArea
    }
    
    @ViewBuilder
    var mapArea: some View {
        MapView(coordinates: landmark.coordinates)
            .scaledToFit()
    }
    
    @ViewBuilder
    var imageArea: some View {
        CircleImage(image: landmark.image)
            .scaledToFit()
    }
    
    @ViewBuilder
    var titleArea: some View {
        Text(landmark.name)
            .font(.headline)
            .lineLimit(0)
        
        Toggle(isOn: $landmark.isFavorite) {
            Text("Favorite")
        }
    }
    
    @ViewBuilder
    var subTitleArea: some View {
        Text(landmark.park)
            .font(.caption)
            .bold()
            .lineLimit(0)
        
        Text(landmark.state)
            .font(.caption)
    }
}

#Preview {
    
    @Previewable @State var modelData = ModelData()
    
    NavigationStack {
        LandmarkDetail(landmark: modelData.bindingLandmarks[0])
            .environment(modelData)
            .navigationBarTitleDisplayMode(.inline)
    }
}

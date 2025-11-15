//
//  LandmarkDetail (macOS).swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/10/12.
//

import SwiftUI
import MapKit

struct LandmarkDetail: View {
    
    @Binding var landmark: Landmark
    
    var body: some View {
        ScrollView {
            mapArea
            contentArea
        }
        .navigationTitle(landmark.name)
    }
}

private extension LandmarkDetail {
    
    @ViewBuilder
    var imageArea: some View {
        CircleImage(image: landmark.image)
            .frame(width: 160, height: 160)
    }
    
    @ViewBuilder
    var headerArea: some View {
        VStack(alignment: .leading) {
            titleArea
            subTitleArea
        }
    }
    
    @ViewBuilder
    var titleArea: some View {
        HStack {
            Text(landmark.name)
                .font(.title)
            
            FavoriteButton(
                isSet: $landmark.isFavorite
            )
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    var subTitleArea: some View {
        VStack(alignment: .leading) {
            Text(landmark.park)
            Text(landmark.state)
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    
    @ViewBuilder
    var summaryArea: some View {
        HStack(spacing: 24) {
            imageArea
            headerArea
        }
    }
    
    @ViewBuilder
    var descriptionArea: some View {
        Text("About \(landmark.name)")
            .font(.title2)
        Text(landmark.description)
    }
    
    @ViewBuilder
    var mapArea: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {

            MapView(coordinates: landmark.coordinates)
            .frame(height: 300)

            Button("Open in Maps") {
                let location = CLLocation(landmark.coordinates)
                let destination = MKMapItem(location: location, address: nil)
                
                destination.name = landmark.name
                destination.openInMaps()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    var contentArea: some View {
        VStack(alignment: .leading, spacing: 20) {
            summaryArea
                .offset(y: -50)
                .padding(.bottom, -50)
            Divider()
            descriptionArea
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    LandmarkDetail(landmark: $modelData.landmarks[0])
        .frame(width: 850, height: 700)
}

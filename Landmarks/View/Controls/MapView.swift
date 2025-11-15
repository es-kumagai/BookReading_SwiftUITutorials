//
//  MapView.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/05.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @AppStorage("MapView.zoom")
    private var zoom = Zoom()
    
    let coordinates: Landmark.Coordinates
    
    var body: some View {
        Map(position: .constant(.region(region)))
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(coordinates),
            span: regionSpan
        )
    }
}

private extension MapView {
    
    var regionSpan: MKCoordinateSpan {
        let delta: CLLocationDegrees = switch zoom {
        case .near: 0.02
        case .medium: 0.2
        case .far: 2
        }
        
        return MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
    }
}

#Preview {
    MapView(coordinates: .init(latitude: 0, longitude: 0))
}

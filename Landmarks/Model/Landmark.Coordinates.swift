//
//  Landmark.Coordinates.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/06.
//

import Foundation
import CoreLocation

extension Landmark {
    struct Coordinates: Sendable, Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

extension CLLocationCoordinate2D {
    init(_ location: Landmark.Coordinates) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}

extension CLLocation {
    convenience init(_ location: Landmark.Coordinates) {
        let location = CLLocationCoordinate2D(location)
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}

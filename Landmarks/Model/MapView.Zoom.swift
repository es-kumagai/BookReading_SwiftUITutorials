//
//  MapView.Zoom.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/10/20.
//

import SwiftUI

extension MapView {
    
    enum Zoom: String, CaseIterable {
        case near = "Near"
        case medium = "Medium"
        case far = "Far"
    }
}

extension MapView.Zoom {

    init() {
        self = .medium
    }
}

extension MapView.Zoom: Identifiable {
    
    var id: MapView.Zoom {
        self
    }
}

extension MapView.Zoom: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}

extension Text {
    
    init(_ zoom: MapView.Zoom) {
        self.init(verbatim: String(describing: zoom))
    }
}

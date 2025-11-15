//
//  LandmarkSettings.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/10/20.
//

import SwiftUI

struct LandmarkSettings: View {
    
    @AppStorage("MapView.zoom")
    private var zoom = MapView.Zoom()
    
    var body: some View {
        Form {
            Picker("Map Zoom:", selection: $zoom) {
                ForEach(MapView.Zoom.allCases, content: Text.init)
            }
            .pickerStyle(.inline)
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}

#Preview {
    LandmarkSettings()
}

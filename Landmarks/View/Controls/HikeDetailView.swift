//
//  HikeView.DetailView
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/10/10.
//

import SwiftUI

#if os(watchOS)
private typealias ButtonStack = VStack
#elseif os(iOS)
private typealias ButtonStack = HStack
#elseif os(macOS)
private typealias ButtonStack = HStack
#endif

extension HikeView {
        
    struct DetailView: View {
        
        typealias DataPath = KeyPath<Hike.Observation, Range<Double>>
        
        let hike: Hike
        
        @State private var dataPath: DataPath = \.elevation
        
        var buttonItems = [
            ButtonItem(title: "Elevation", dataPath: \.elevation),
            ButtonItem(title: "Heart Rate", dataPath: \.heartRate),
            ButtonItem(title: "Pace", dataPath: \.pace)
        ]
        
        var body: some View {
            VStack {
                HikeGraph(hike: hike, path: dataPath)
                    .frame(height: 200)
                buttonsBar
            }
        }
    }
}

extension HikeView.DetailView {
        
    var buttonsBar: some View {
        ButtonStack {
            ForEach(buttonItems, id: \.title) { item in
                ButtonView(item: item, isSelected: item.dataPath == dataPath) { item in
                    dataPath = item.dataPath
                }
            }
        }
    }
}

#Preview("Hike Detail") {
    HikeView.DetailView(hike: ModelData().hikes[0])
}


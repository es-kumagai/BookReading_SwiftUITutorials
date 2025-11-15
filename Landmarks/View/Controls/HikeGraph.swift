//
//  HikeGraph.swift
//  Landmarks for iOS
//
//  Created by とりあえず読書会 on 2025/10/10.
//

import SwiftUI

extension HikeView {
    
    struct HikeGraph: View {
        
        let hike: Hike
        let path: KeyPath<Hike.Observation, Range<Double>>
        
        var color: Color {
            switch path {
            case \.elevation:
                    .elevationHikeGraph
            case \.heartRate:
                    .heartRateHikeGraph
            case \.pace:
                    .paceHikeGraph
            default:
                    .unknownHikeGraph
            }
        }
        
        var body: some View {
            GeometryReader { proxy in
                let observations = hike.observations
                if !observations.isEmpty {
                    graphView(bounds: proxy.size, observations: observations)
                }
            }
        }
    }
}

private extension HikeView.HikeGraph {
    
    struct Capsule: View, Equatable {
        let index: Int
        let color: Color
        let height: Double
        let range: Range<Double>
        let overallRange: Range<Double>

        var heightRatio: Double {
            max(range.magnitude / overallRange.magnitude, 0.15)
        }

        var offsetRatio: Double {
            (range.lowerBound - overallRange.lowerBound) / overallRange.magnitude
        }

        var body: some View {
            SwiftUI.Capsule()
                .fill(color)
                .frame(height: height * heightRatio)
                .offset(x: 0, y: height * -offsetRatio)
        }
    }
    
    func graphView(bounds: CGSize, observations: some Collection<Hike.Observation>) -> some View {
        
        precondition(!observations.isEmpty)
        
        let observationRanges = observations.map { $0[keyPath: path] }
        let overallRange = observationRanges.smallestEnclosingRange!
        
        precondition(!overallRange.isEmpty)
        
        let heightRatio = 1 - observationRanges.maxMagnitude! / overallRange.magnitude

        return HStack(alignment: .bottom, spacing: bounds.width / 120) {
            ForEach(Array(observations.enumerated()), id: \.offset) { index, observation in
                Capsule(
                    index: index,
                    color: color,
                    height: bounds.height,
                    range: observation[keyPath: path],
                    overallRange: overallRange
                )
                .animation(.ripple(delayFactor: Double(index)))
            }
            .offset(x: 0, y: bounds.height * heightRatio)
        }
    }
}

#Preview("Graph") {
    let hike = ModelData().hikes[0]
    return Group {
        HikeView.HikeGraph(hike: hike, path: \.elevation)
            .frame(height: 200)
        HikeView.HikeGraph(hike: hike, path: \.heartRate)
            .frame(height: 200)
        HikeView.HikeGraph(hike: hike, path: \.pace)
            .frame(height: 200)
    }
}

#Preview("Capsule") {
    HikeView.HikeGraph.Capsule(
            index: 0,
            color: .blue,
            height: 150,
            range: 10..<50,
            overallRange: 0..<100)
}

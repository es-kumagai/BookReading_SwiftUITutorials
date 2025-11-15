//
//  Hike.Observation.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/15.
//

extension Hike {
    
    typealias Observations = [Observation]
    
    struct Observation: Sendable, Codable, Hashable {
        var distanceFromStart: Double

        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}

extension Sequence<Range<Double>> {
    
    var maxMagnitude: Double? {
        lazy.map(\.magnitude).max()
    }
}

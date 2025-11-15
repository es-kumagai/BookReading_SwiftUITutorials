//
//  Hike.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/15.
//

import Foundation

typealias Hikes = [Hike]

struct Hike: Sendable, Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: Observations

    nonisolated(unsafe)
    private static let formatter = LengthFormatter()
    
    var distanceText: String {
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }
}

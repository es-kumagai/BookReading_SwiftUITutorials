//
//  Profile.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/20.
//

import Foundation

struct Profile: Sendable {
    var username: String
    var prefersNotifications: Bool
    var seasonalPhoto: Season
    var goalDate: Date
}

extension Profile {
    
    enum Season: Sendable, CaseIterable {
        case spring
        case summer
        case autumn
        case winter
    }
}

extension Profile.Season: Identifiable {
    
    var id: Self {
        self
    }
}

extension Profile.Season {
    
    var symbol: String {
        switch self {
        case .spring: "🌷"
        case .summer: "🌞"
        case .autumn: "🍂"
        case .winter: "☃️"
        }
    }
}

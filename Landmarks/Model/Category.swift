//
//  Category.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/18.
//

typealias Categories = [Category]

enum Category: String, Sendable, Codable, CaseIterable {
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"
}

extension Category: Identifiable {
    
    var id: Self {
        self
    }
}

extension Category: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}

extension Category: Comparable {
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

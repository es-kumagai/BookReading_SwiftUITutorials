//
//  Landmark.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/06.
//

import SwiftUI

typealias Landmarks = [Landmark]

typealias BindingLandmark = Binding<Landmark>
typealias BindingLandmarks = [BindingLandmark]
typealias BindingLandmarksByCategory = [Category: BindingLandmarks]

struct Landmark: Sendable, Codable, Hashable, Identifiable {
    
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var image: Image
    var coordinates: Coordinates
    var isFavorite: Bool
    var category: Category
    var isFeatured: Bool
}

private extension Landmark {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case park
        case state
        case description
        case image = "imageName"
        case coordinates
        case isFavorite
        case category
        case isFeatured
    }
}

extension BindingLandmarksByCategory {
    
    var categories: some Sequence<Category> {
        keys
    }
}

extension Binding<Landmarks> {
    
    init(_ landmarks: BindingLandmarks) {
        let getter = { @Sendable in
            landmarks.map(\.wrappedValue)
        }
        
        let setter = { @Sendable (newLandmarks: Landmarks) in
            assert(landmarks.map(\.id) == newLandmarks.map(\.id), "Landmarks のバインディングが崩れています。")
            
            for (bindingLandmark, newLandmark) in zip(landmarks, newLandmarks) {
                bindingLandmark.wrappedValue = newLandmark
            }
        }
        
        self.init(get: getter, set: setter)
    }
}

extension Sequence where Element: Identifiable {
    
    func element(byID id: Element.ID) -> Element? {
        first { element in
            element.id == id
        }
    }
    
    subscript (id id: Element.ID) -> Element? {
        element(byID: id)
    }
}

extension Sequence<Landmark> {
    
    func isSameCategory(as category: Category) -> Bool {
        allSatisfy { landmark in
            landmark.category == category
        }
    }
    
    var isSameCategory: Bool {
        var iterator = makeIterator()
        
        guard let firstElement = iterator.next() else {
            return true
        }
        
        return AnySequence { iterator }.isSameCategory(as: firstElement.category)
    }
}

extension Sequence<BindingLandmark> {
    
    func isSameCategory(as category: Category) -> Bool {
        lazy.map(\.wrappedValue).isSameCategory(as: category)
    }
    
    var isSameCategory: Bool {
        lazy.map(\.wrappedValue).isSameCategory
    }
}

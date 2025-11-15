//
//  Image.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/06.
//

import SwiftUI

extension Landmark {
    
    struct Image: Sendable, Hashable {
        var name: String
    }
}

extension Landmark.Image: Codable {
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        name = try container.decode(String.self)
    }
    
    private enum CodingKeys: CodingKey {
        case name
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(name)
    }
    
    init?(featureImageOf landmark: Landmark) {
        guard landmark.isFeatured else {
            return nil
        }

        self.init(name: "\(landmark.image.name)_feature")
    }
}

extension SwiftUI.Image {
    
    init(_ image: Landmark.Image) {
        self.init(image.name)
    }
    
    init?(featureImageOf landmark: Landmark) {
        guard let image = Landmark.Image(featureImageOf: landmark) else {
            return nil
        }
        
        self.init(image)
    }
}

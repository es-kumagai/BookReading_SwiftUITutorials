//
//  ModelData.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/06.
//

import Foundation
import SwiftUI

@Observable
final class ModelData {
        
    var landmarks: Landmarks
    var hikes: Hikes
    private var profile: Profile?

    static let defaultProfile = Profile(username: "g_kumar", prefersNotifications: true, seasonalPhoto: .winter, goalDate: .now)
    
    var defaultProfile: Profile {
        Self.defaultProfile
    }
    
    var effectiveProfile: Profile {
        get {
            profile ?? defaultProfile
        }
        
        set (newProfile) {
            profile = newProfile
        }
    }

    init(bundle: Bundle = .main) {
        landmarks = bundle.read(fromResource: "landmarkData", withExtension: "json", as: Landmarks.self)
        hikes = bundle.read(fromResource: "hikeData", withExtension: "json", as: Hikes.self)
    }
}

extension ModelData {
    
    var bindingLandmarks: Binding<Landmarks> {
        @Bindable var modelData = self
        return $modelData.landmarks
    }

    var bindingLandmarksByCategory: BindingLandmarksByCategory {
        BindingLandmarksByCategory(grouping: bindingLandmarks, by: \.wrappedValue.category)
    }
    
    var bindingFeaturedLandmarks: Binding<Landmarks> {
        let landmarks = bindingLandmarks
            .filter(\.wrappedValue.isFeatured)
        return Binding(landmarks)
    }
}

extension Bundle {
    func read<Value: Decodable>(fromResource resource: String, withExtension extension: String, as _: Value.Type) -> Value {
        
        guard let url = url(forResource: resource, withExtension: `extension`) else {
            fatalError("Couldn't find \(resource) in bundle \(String(describing: bundleIdentifier)).")
        }
        
        let data: Data
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("""
                Couldn't load \(resource) from the bundle:
                \(error)
                """)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Value.self, from: data)
        } catch let error as DecodingError {
            
            let reason = switch error {
                
            case .dataCorrupted(let context):
                "Data corrupted in \(context)"
                
            case .typeMismatch(let expectedType, let context):
                "Type mismatch in \(context): expected: \(expectedType)"
                
            case .valueNotFound(let type, let context):
                "Value not found in \(context): \(type)"
                
            case .keyNotFound(let key, let context):
                "Key '\(key)' not found in \(context)"
                
            @unknown default:
                "Unexpected error: \(error)"
            }
            
            fatalError("Couldn't parse \(resource) as \(Value.self): \(reason)")
        } catch {
            fatalError("""
                Couldn't parse \(resource) as \(Value.self):
                \(error)
                """)
        }
    }
}

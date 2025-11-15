//
//  CategoryHome.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/18.
//

import SwiftUI

struct CategoryHome: View {
    
    @Environment(ModelData.self) var modelData
    @Binding var showingProfile: Bool
    
    var landmarksByCategory: BindingLandmarksByCategory {
        modelData.bindingLandmarksByCategory
    }
    
    var featuredLandmarks: Binding<Landmarks> {
        modelData.bindingFeaturedLandmarks
    }
    
    var featureCards: [FeatureCard] {
        featuredLandmarks
            .lazy
            .map(\.wrappedValue)
            .map(FeatureCard.init(landmark:))
    }
    
    var hasFeatureCards: Bool {
        !featureCards.isEmpty
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                let landmarksByCategory = landmarksByCategory
                    .filter { _, landmarks in
                        !landmarks.isEmpty
                    }
                
                if hasFeatureCards {
                    PageView(pages: featureCards)
                        .listRowInsets(EdgeInsets())
                }
                
                ForEach(landmarksByCategory.categories.sorted()) { category in
                    CategoryRow(landmarks: Binding(landmarksByCategory[category]!))
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle(hasFeatureCards ? "Featured" : "Landmarks")
            .profileToolbar($showingProfile)
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    @Previewable @State var showingProfile = false
    CategoryHome(showingProfile: $showingProfile)
        .environment(ModelData())
}

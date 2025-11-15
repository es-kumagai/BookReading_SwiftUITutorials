//
//  CategoryRow.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/18.
//

import SwiftUI

struct CategoryRow: View {
    
    let category: Category
    @Binding var landmarks: Landmarks
    
    init(category: Category, landmarks: Binding<Landmarks>) {
        assert(landmarks.isSameCategory(as: category), "全て同じカテゴリーの Landmark を渡す必要があります。")
        
        self.category = category
        self._landmarks = landmarks
    }
    
    init(landmarks: some Collection<BindingLandmark>) {
        assert(!landmarks.isEmpty, "１つ以上の Landmark を渡す必要があります。")
        
        self.init(category: landmarks.first!.category.wrappedValue, landmarks: Binding(Array(landmarks)))
    }
    
    var body: some View {
        
        VStack {
            categoryHeader
            landmarkCells
        }
    }
}

private extension CategoryRow {
    
    @ViewBuilder
    var categoryHeader: some View {
        Text(category)
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)
    }
    
    @ViewBuilder
    var landmarkCells: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach($landmarks) { landmark in
                    landmarkCell(for: landmark)
                }
            }
        }
        .frame(height: 185)
    }
    
    @ViewBuilder
    func landmarkCell(for landmark: BindingLandmark) -> some View {
        NavigationLink {
            LandmarkDetail(landmark: landmark)
        } label: {
            LandmarkCell(landmark.wrappedValue)
        }
    }
}

private extension CategoryRow {
    
    struct LandmarkCell: View {
        
        let landmark: Landmark
        
        init(_ landmark: Landmark) {
            self.landmark = landmark
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Image(landmark.image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                Text(landmark.name)
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
            .padding(.leading, 15)
        }
    }
}

#Preview("Row") {
    let category = Category.rivers
    let landmarks = ModelData().bindingLandmarks.filter { landmark in
        landmark.wrappedValue.category == category
    }
    
    GeometryReader { _ in
        CategoryRow(category: category, landmarks: Binding(landmarks))
    }
}

extension Text {
    init(_ category: Category) {
        self.init(verbatim: String(describing: category))
    }
}

#Preview("Cell") {
    CategoryRow.LandmarkCell(ModelData().bindingLandmarks[0].wrappedValue)
}

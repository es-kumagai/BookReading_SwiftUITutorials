//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/08.
//

import SwiftUI

struct LandmarkRow: View {
    
    @Binding private(set) var landmark: Landmark
    
    var body: some View {
        HStack {
            imageArea
            contentArea
        }
        .padding(.vertical, 4)
    }
}

private extension LandmarkRow {
    
    @ViewBuilder
    var imageArea: some View {
        Image(landmark.image)
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(5)
    }
    
    @ViewBuilder
    var contentArea: some View {
        summaryArea
        Spacer()
        accessoryArea
    }
    
    @ViewBuilder
    var summaryArea: some View {
        VStack(alignment: .leading) {
            titleArea
            #if !os(watchOS)
            subTitleArea
            #endif
        }
    }
    
    @ViewBuilder
    var accessoryArea: some View {
        if landmark.isFavorite {
            StarImage.active
        }
    }

    @ViewBuilder
    var titleArea: some View {
        Text(landmark.name)
            .bold()
    }
    
    @ViewBuilder
    var subTitleArea: some View {
        Text(landmark.park)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

#Preview("First Row") {
    let modelData = ModelData()
    LandmarkRow(landmark: modelData.bindingLandmarks[0])
}

#Preview("Second Row") {
    let modelData = ModelData()
    LandmarkRow(landmark: modelData.bindingLandmarks[1])
}

#Preview("Group") {
    let modelData = ModelData()
    Group {
        LandmarkRow(landmark: modelData.bindingLandmarks[0])
        LandmarkRow(landmark: modelData.bindingLandmarks[1])
    }
}

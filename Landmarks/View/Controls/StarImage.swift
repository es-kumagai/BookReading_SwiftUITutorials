//
//  StarImage.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/10.
//

import SwiftUI

struct StarImage: View {
    
    let isActive: Bool
    let tintColor: Color
    
    init(isActive: Bool, tintColor: Color = .yellow) {
        self.isActive = isActive
        self.tintColor = tintColor
    }
    
    var body: some View {
        Image(systemImage: systemImage)
            .foregroundStyle(effectiveColor)
    }
}

extension StarImage {
    
    static let active = StarImage(isActive: true)
    static let inactive = StarImage(isActive: false)
}

private extension StarImage {
    
    var systemImage: SystemImage {
        isActive ? .starFill : .star
    }
    
    var effectiveColor: Color {
        isActive ? tintColor : .gray
    }
}

#Preview {
    Group {
        StarImage(isActive: true, tintColor: .blue)
        StarImage(isActive: false, tintColor: .green)
    }
}

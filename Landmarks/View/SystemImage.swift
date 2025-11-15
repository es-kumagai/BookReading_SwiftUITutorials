//
//  SystemImage.swift
//  Landmarks for iOS
//
//  Created by とりあえず読書会 on 2025/11/11.
//

import SwiftUI

enum SystemImage: String {
    case chevronRightCircle = "chevron.right.circle"
    case listBullet = "list.bullet"
    case personCropCircle = "person.crop.circle"
    case sliderHorizontal3 = "slider.horizontal.3"
    case star = "star"
    case starFill = "star.fill"
    case xmark = "xmark"
}

extension Label<Text, Image> {
    init(_ titleKey: LocalizedStringKey, systemImage: SystemImage) {
        self.init(titleKey, systemImage: systemImage.rawValue)
    }
}

extension Image {
    init(systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}

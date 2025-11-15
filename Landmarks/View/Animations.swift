//
//  Animations.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/15.
//

import SwiftUI

extension Animation {
    static func ripple(delayFactor factor: Double) -> Animation {
        .spring(dampingFraction: 0.5)
        .speed(2)
        .delay(0.03 * factor)
    }
}

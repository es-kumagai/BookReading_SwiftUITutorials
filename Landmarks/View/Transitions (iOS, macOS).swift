//
//  Transitions.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/15.
//

import SwiftUI

@MainActor
extension AnyTransition {
    static let moveAndFade: AnyTransition = .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .scale.combined(with: .opacity))
}

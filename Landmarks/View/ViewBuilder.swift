//
//  ViewBuilder.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/24.
//

import SwiftUI

#if DEBUG
extension ViewBuilder {
    /// print 関数などのように、Void を返す機能を View Builder の中に入れ込めるようにするための実装です。
    /// デバッグの時だけ、利用できるようにします。
    public static func buildExpression(_ expression: Void) -> EmptyView {
        EmptyView()
    }
}
#endif

//
//  Style.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/13.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    
    static var badgeSymbol: Color {
        Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    }
    
    static var elevationHikeGraph: Color {
        .gray
    }
    
    static var heartRateHikeGraph: Color {
        Color(hue: 0, saturation: 0.5, brightness: 0.7)
    }
    
    static var paceHikeGraph: Color {
        Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
    }
    
    static var unknownHikeGraph: Color {
        .black
    }
}

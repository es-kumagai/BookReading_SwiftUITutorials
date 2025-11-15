//
//  Badge.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/14.
//

import SwiftUI

struct Badge: View {

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let bounds = geometry.size
                
                Background(bounds: bounds)
                Symbols(bounds: bounds, opacity: 0.5)
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: bounds.width / 2.0, y: bounds.height * (3.0 / 4.0))
            }
        }
        .scaledToFit()
    }
}

private extension Badge {
    
    struct Symbols: View {
        
        let bounds: CGSize
        let opacity: Double
        
        var body: some View {
            ForEach(0..<8) { index in
                let angle = Angle.degrees(Double(index) / 8) * 360
                RotatedSymbol(bounds: bounds, angle: angle, fillStyle: .badgeSymbol
                )
            }
            .opacity(opacity)
        }
    }
    
    struct RotatedSymbol: View {

        let bounds: CGSize
        let angle: Angle
        let fillStyle: any ShapeStyle
        let padding: Double = -60
        
        var body: some View {
            Symbol(bounds: bounds, fillStyle: fillStyle)
                .padding(padding)
                .rotationEffect(angle, anchor: .bottom)
        }
    }
    
    struct Symbol: View {
        
        let bounds: CGSize
        let fillStyle: any ShapeStyle
        
        private var squareSizeLength: Double {
            min(bounds.width, bounds.height)
        }
        
        private var bottomPortionHight: Double {
            squareSizeLength * 0.75
        }
        
        private var spacing: Double {
            squareSizeLength * 0.030
        }
        
        private var squareSizeHalfLength: Double {
            squareSizeLength * 0.5
        }
        
        private var topPortionSize: CGSize {
            CGSize(
                width: squareSizeLength * 0.226,
                height: bottomPortionHight * 0.488
            )
        }
        
        var body: some View {
            Path(makePath)
                .fill(.badgeSymbol)
        }
    }
    
    struct Background: View {
        
        let bounds: CGSize
        
        var body: some View {
            Group {
                let squareSizeLength = min(bounds.width, bounds.height)
                let canvasSize = CGSize(width: squareSizeLength, height: squareSizeLength)
                
                HexagonPath(canvasSize: canvasSize)
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

private extension Badge.Symbol {
    
    func makeSpacingPath(_ path: inout Path) {
        path.move(to: CGPoint(x: squareSizeHalfLength, y: topPortionSize.height / 2 + spacing * 3))
    }

    func makeTopPortionPath(_ path: inout Path) {
        path.addLines([
            CGPoint(x: squareSizeHalfLength, y: spacing),
            CGPoint(x: squareSizeHalfLength - topPortionSize.width, y: topPortionSize.height - spacing),
            CGPoint(x: squareSizeHalfLength, y: topPortionSize.height / 2 + spacing),
            CGPoint(x: squareSizeHalfLength + topPortionSize.width, y: topPortionSize.height - spacing),
            CGPoint(x: squareSizeHalfLength, y: spacing)
        ])
    }
    
    func makeBottomPortionPath(_ path: inout Path) {
        path.addLines([
            CGPoint(x: squareSizeHalfLength - topPortionSize.width, y: topPortionSize.height + spacing),
            CGPoint(x: spacing, y: bottomPortionHight - spacing),
            CGPoint(x: squareSizeLength - spacing, y: bottomPortionHight - spacing),
            CGPoint(x: squareSizeHalfLength + topPortionSize.width, y: topPortionSize.height + spacing),
            CGPoint(x: squareSizeHalfLength, y: topPortionSize.height / 2 + spacing * 3)
        ])
    }
    
    func makePath(_ path: inout Path) {
        makeTopPortionPath(&path)
        makeSpacingPath(&path)
        makeBottomPortionPath(&path)
    }
}

private extension Badge.Background {
    
    struct HexagonPath: View {
        
        let canvasSize: CGSize
        let parameter = Parameter()
        
        private var badgeSize: CGSize {
            CGSize(width: canvasSize.width * parameter.xScale, height: canvasSize.height)
        }

        private var xOffset: Double {
            (canvasSize.width * (1 - parameter.xScale)) / 2
        }
        
        var body: some View {
            
            Path(makePath)
            .fill(
                .linearGradient(
                    Gradient(colors: parameter.gradientColors),
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 0.6)
                )
            )
        }
    }
}

private extension Badge.Background.HexagonPath {

    func makePath(_ path: inout Path) {
        path.move(
            to: CGPoint(
                x: badgeSize.width * 0.95 + xOffset,
                y: badgeSize.height * (0.20 + parameter.adjustment)
            )
        )

        for segment in parameter.segments {
            path.addLine(
                to: CGPoint(
                    x: badgeSize.width * segment.line.x + xOffset,
                    y: badgeSize.height * segment.line.y
                )
            )

            path.addQuadCurve(
                to: CGPoint(
                    x: badgeSize.width * segment.curve.x + xOffset,
                    y: badgeSize.height * segment.curve.y
                ),
                control: CGPoint(
                    x: badgeSize.width * segment.control.x + xOffset,
                    y: badgeSize.height * segment.control.y
                )
            )
        }
    }
}

private extension Badge.Background.HexagonPath {
    
    struct Segment: Sendable {
        var line: CGPoint
        var curve: CGPoint
        var control: CGPoint
    }
    
    struct Parameter: Sendable {
        
        typealias Segment = Badge.Background.HexagonPath.Segment
        
        var adjustment = 0.085
        var gradientColors = [
            Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255),
            Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
        ]

        var xScale = 0.832

        var segments: [Segment] {
            [
                Segment(
                    line:    CGPoint(x: 0.60, y: 0.05),
                    curve:   CGPoint(x: 0.40, y: 0.05),
                    control: CGPoint(x: 0.50, y: 0.00)
                ),
                Segment(
                    line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
                    curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
                    control: CGPoint(x: 0.00, y: 0.25 + adjustment)
                ),
                Segment(
                    line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
                    curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
                    control: CGPoint(x: 0.00, y: 0.75 - adjustment)
                ),
                Segment(
                    line:    CGPoint(x: 0.40, y: 0.95),
                    curve:   CGPoint(x: 0.60, y: 0.95),
                    control: CGPoint(x: 0.50, y: 1.00)
                ),
                Segment(
                    line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
                    curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
                    control: CGPoint(x: 1.00, y: 0.75 - adjustment)
                ),
                Segment(
                    line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
                    curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
                    control: CGPoint(x: 1.00, y: 0.25 + adjustment)
                )
            ]
        }
    }
}

#Preview("Badge") {
    Badge()
}

#Preview("Background") {
    GeometryReader { geometry in
        Badge.Background(bounds: geometry.size)
    }
}

#Preview("Symbols") {
    GeometryReader { geometry in
        Badge.Symbols(bounds: geometry.size, opacity: 0.5)
    }
}

#Preview("RotatedSymbol") {
    GeometryReader { geometry in
        Badge.RotatedSymbol(bounds: geometry.size, angle: Angle(degrees: 5), fillStyle: .badgeSymbol)
    }
}

#Preview("Symbol") {
    GeometryReader { geometry in
        Badge.Symbol(bounds: geometry.size, fillStyle: .badgeSymbol)
    }
}

//
//  Range.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/16.
//

protocol EnclosableRange<Bound>: RangeExpression {

    var lowerBound: Bound { get }
    var upperBound: Bound { get }
    
    init(uncheckedBounds bounds: (lower: Bound, upper: Bound))
}

extension EnclosableRange where Bound: AdditiveArithmetic {
    var magnitude: Bound {
        upperBound - lowerBound
    }
}

extension Range: EnclosableRange {}
extension ClosedRange: EnclosableRange {}

extension Sequence where Element: EnclosableRange {
    
    var smallestEnclosingRange: Element? {
        var rangeIterator = makeIterator()
        guard let range = rangeIterator.next() else {
            return nil
        }

        var lower = range.lowerBound
        var upper = range.upperBound
        
        while let range = rangeIterator.next() {
            lower = Swift.min(lower, range.lowerBound)
            upper = Swift.max(upper, range.upperBound)
        }

        return Element(uncheckedBounds: (lower, upper))
    }
}

//
//  PageNumber.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/09/28.
//

import SwiftUI

/// １から始まるページ番号
struct PageNumber: Sendable, Hashable {
    let value: Int
    
    init(_ value: Int) {
        self.value = value
    }
}

extension PageNumber: Comparable {
    static func < (lhs: PageNumber, rhs: PageNumber) -> Bool {
        lhs.value < rhs.value
    }
}

extension PageNumber: CustomStringConvertible {
    var description: String {
        "\(value)"
    }
}

extension PageNumber: CustomDebugStringConvertible {
    
    var debugDescription: String {
        "Page \(value)"
    }
}

extension PageNumber: ExpressibleByIntegerLiteral {

    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension PageNumber: AdditiveArithmetic {
    
    static var zero: Self {
        0
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.value + rhs.value)
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.value - rhs.value)
    }
}

extension PageNumber {
    
    static var start: Self {
        1
    }
    
    init(offset: Int) {
        value = offset + 1
    }

    /// ページ番号を 0 から始まるオフセット値で取得します。
    var offset: Int {
        value - 1
    }
    
    var next: Self {
        self + 1
    }
    
    var previous: Self {
        self - 1
    }
    
    mutating func moveNext() {
        self = next
    }
    
    mutating func movePrevious() {
        self = previous
    }
    
    static func + (lhs: Self, offset: Int) -> Self {
        Self(lhs.value + offset)
    }
    
    static func - (lhs: Self, offset: Int) -> Self {
        Self(lhs.value - offset)
    }
}

extension LocalizedStringKey.StringInterpolation {
    mutating func appendInterpolation(_ pageNumber: PageNumber) {
        appendInterpolation(String(describing: pageNumber))
    }
}

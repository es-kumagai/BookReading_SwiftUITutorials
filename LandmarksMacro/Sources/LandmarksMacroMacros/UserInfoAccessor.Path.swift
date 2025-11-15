//
//  UserInfoAccessor.Path.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/11/03.
//

import SwiftSyntax

extension UserInfoAccessor {
    
    struct Path {
        private var names: [String]
        
        init() {
            names = []
        }
        
        init(_ name: String) {
            names = [name]
        }
        
        init(_ names: some Sequence<String>) {
            self.names = Array(names)
        }
        
        init(_ name: TokenSyntax) {
            self.init(name.text)
        }
    }
}

extension UserInfoAccessor.Path {
    
    mutating func append(_ name: some StringProtocol) {
        names.append(String(name))
    }
    
    func appending(_ name: some StringProtocol) -> Self {
        var result = self
        result.append(name)
        
        return result
    }
    
    func dropFirst() -> Self {
        Self(names.dropFirst())
    }
}

extension UserInfoAccessor.Path: Sequence {
    
    func makeIterator() -> some IteratorProtocol {
        names.makeIterator()
    }
}

extension UserInfoAccessor.Path: CustomStringConvertible {
    
    var description: String {
        guard let firstName = names.first else {
            return ""
        }
        
        return names
            .dropFirst()
            .lazy
            .map(\.upperCamelcased)
            .reduce(into: firstName.lowerCamelcased, +=)
    }
}

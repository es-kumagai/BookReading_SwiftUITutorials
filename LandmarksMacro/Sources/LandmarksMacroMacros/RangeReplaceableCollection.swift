//
//  RangeReplaceableCollection.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/11/03.
//

import SwiftSyntax

extension RangeReplaceableCollection<DeclSyntax> {

    mutating func append(_ name: UserInfoAccessor.Path, forKey key: some StringProtocol, as type: some StringProtocol, to dictionary: UserInfoAccessor.Path, protection: (some StringProtocol)?) {
        append(
            String(describing: name),
            forKey: key,
            as: type,
            to: String(describing: dictionary),
            protection: protection
        )
    }
    
    mutating func append(_ name: some StringProtocol, forKey key: some StringProtocol, as type: some StringProtocol, to dictionary: some StringProtocol, protection: (some StringProtocol)?) {
        
        let protection = protection.map { "\($0) " } ?? ""
        
        append("""
            
            \(raw: protection)var \(raw: name): \(raw: type)! {
                \(raw: dictionary)["\(raw: key)"] as? \(raw: type)
            }
            """)
    }
}

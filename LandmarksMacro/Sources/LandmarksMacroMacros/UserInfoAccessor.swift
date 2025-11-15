//
//  File.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/10/24.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct UserInfoAccessor: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        for member in declaration.memberBlock.members {
            
            guard let enumNode = member.decl.as(EnumDeclSyntax.self), enumNode.name.text == "UserInfo" else {
                continue
            }
            
            return EnumMemberBlockVisitor.expansion(for: enumNode)
        }
        
        return []
    }
}

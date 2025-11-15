//
//  UserInfoAccessor.EnumMemberBlockVisitor.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/11/03.
//

import SwiftSyntax

extension UserInfoAccessor {
    
    final class EnumMemberBlockVisitor: SyntaxVisitor {
        
        typealias Path = UserInfoAccessor.Path
        
        let path: Path
        private(set) var expansion: [DeclSyntax] = []
        
        convenience init(name: some StringProtocol, viewMode: SyntaxTreeViewMode) {
            self.init(path: Path(String(name)), viewMode: viewMode)
        }
        
        init(path: Path, viewMode: SyntaxTreeViewMode) {
            self.path = path
            super.init(viewMode: viewMode)
        }
        
        override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
            
            let name = node.name.text
            let namePath = path.appending(name)

            expansion.append(
                namePath,
                forKey: name.lowerCamelcased,
                as: "[String: Any]",
                to: path,
                protection: "private"
            )
            
            expansion += Self.expansion(for: node.memberBlock, path: namePath, viewMode: viewMode)
            
            return .skipChildren
        }
        
        override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
            
            for element in node.elements {
                guard element.parameterClause?.parameters.count == 1 else {
                    fatalError("The enum case for UserInfoAccessor must have only one parameter.")
                }
                
                let name = element.name.text
                let namePath = path.appending(name)
                let type = element.parameterClause!.parameters.first!.description
                let protection = nil as String?
                
                expansion.append(
                    namePath,
                    forKey: name,
                    as: type,
                    to: path,
                    protection: protection
                )
            }
            
            return .skipChildren
        }
    }
}

extension UserInfoAccessor.EnumMemberBlockVisitor {
    
    static func expansion(for enumNode: EnumDeclSyntax) -> [DeclSyntax] {
        expansion(for: enumNode.memberBlock, path: Path(enumNode.name), viewMode: .sourceAccurate)
    }
    
    static func expansion(for memberBlock: MemberBlockSyntax, path: Path, viewMode: SyntaxTreeViewMode) -> [DeclSyntax] {

        let visitor = Self(path: path, viewMode: viewMode)
        
        visitor.walk(memberBlock)
        return visitor.expansion
    }
}




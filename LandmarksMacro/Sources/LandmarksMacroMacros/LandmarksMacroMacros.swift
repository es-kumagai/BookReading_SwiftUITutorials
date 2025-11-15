//
//  File.swift
//  LandmarksMacro
//
//  Created by とりあえず読書会 on 2025/10/24.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct LandmarksMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        UserInfoAccessor.self,
    ]
}

//
//  ButtonView.swift
//  Landmarks for iOS
//
//  Created by とりあえず読書会 on 2025/10/10.
//

import SwiftUI

typealias ButtonItems = [ButtonItem]

struct ButtonView: View {
    
    let item: ButtonItem
    let isSelected: Bool
    let action: @MainActor (_ item: ButtonItem) -> Void
    
    var body: some View {
        Button {
            action(item)
        } label: {
            Text(item.title)
                .font(.system(size: 15))
                .foregroundStyle(isSelected ? .gray : .accentColor)
                .animation(nil)
        }
    }
}

struct ButtonItem {

    typealias DataPath = KeyPath<Hike.Observation, Range<Double>>

    var title: String
    var dataPath: DataPath
}

//
//  PageControl.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/10/04.
//

import SwiftUI

struct PageControl: View, UIViewRepresentable {
    
    let numberOfPages: Int
    @Binding private(set) var currentPageNumber: PageNumber
    
    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()

        control.numberOfPages = numberOfPages
        control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        context.coordinator.owner = self
        uiView.currentPage = currentPageNumber.offset
    }
}

extension PageControl {
    
    @MainActor
    final class Coordinator: NSObject {
        
        fileprivate(set) var owner: PageControl
        
        fileprivate init(owner: PageControl) {
            self.owner = owner
        }
    }
}

private extension PageControl.Coordinator {
    @objc
    func updateCurrentPage(sender: UIPageControl) {
        owner.currentPageNumber = PageNumber(offset: sender.currentPage)
    }
}

//
//  PageView.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/09/27.
//

import SwiftUI

struct PageView<Page: View>: View {
    let pages: [Page]
    
    @State private var currentPageNumber: PageNumber

    init(pages: some Sequence<Page>) {
        self.init(pages: Array(pages))
    }
    
    init(pages: [Page]) {
        precondition(!pages.isEmpty, "１つ以上のページを指定する必要があります。")
        self.pages = pages
        self.currentPageNumber = 1
    }
    
    var pageControlWidth: Double {
        Double(pages.count * 18)
    }
    
    var body: some View {
        ZStack {
            PageViewController(pages: pages, currentPageNumber: $currentPageNumber)
            PageControl(numberOfPages: pages.count, currentPageNumber: $currentPageNumber)
                .frame(width: pageControlWidth)
                .padding(.trailing)
        }
        .aspectRatio(3 / 2, contentMode: .fit)
    }
}

#Preview {
    @Previewable @State var pageNumger: PageNumber = 1
    
    let pages = ModelData()
        .bindingFeaturedLandmarks
        .lazy
        .map(\.wrappedValue)
        .map(FeatureCard.init(landmark:))
    PageView(pages: pages)
}

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

struct HikeView: View {

    let hike: Hike

    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                hikeGraph
                landmarkSummary
                Spacer()
                showDetailButton
            }

            if showDetail {
                DetailView(hike: hike)
                    .transition(
                        .moveAndFade)
            }
        }
    }
}

private extension HikeView {
    
    var hikeGraph: some View {
        HikeGraph(hike: hike, path: \.elevation)
            .frame(width: 50, height: 30)
    }
    
    var landmarkSummary: some View {
        VStack(alignment: .leading) {
            Text(hike.name)
                .font(.headline)
            Text(hike.distanceText)
        }
    }
    
    var showDetailButton: some View {
        Button {
            withAnimation {
                showDetail.toggle()
            }
        } label: {
            Label("Graph", systemImage: .chevronRightCircle)
                .labelStyle(.iconOnly)
                .imageScale(.large)
                .rotationEffect(.degrees(showDetail ? 90 : 0))
                .scaleEffect(showDetail ? 1.5 : 1)
                .padding()
        }
    }
}

#Preview("Hike View") {
    VStack {
        HikeView(hike: ModelData().hikes[0])
            .padding()
        Spacer()
    }
}

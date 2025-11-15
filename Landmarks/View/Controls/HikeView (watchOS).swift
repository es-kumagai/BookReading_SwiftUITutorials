/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

struct HikeView: View {

    let hike: Hike

    var body: some View {
        ScrollView {
            VStack {
                landmarkSummary
                landmarkDetail
            }
        }
    }
}

private extension HikeView {
    
    var landmarkSummary: some View {
        VStack(alignment: .leading) {
            Text(hike.name)
                .font(.headline)
            Text(hike.distanceText)
                .font(.footnote)
        }
    }
    
    var landmarkDetail: some View {
        DetailView(hike: hike)
    }
}

#if os(watchOS)
#Preview("Hike View") {
    VStack {
        HikeView(hike: ModelData().hikes[0])
            .padding()
        Spacer()
    }
}
#endif

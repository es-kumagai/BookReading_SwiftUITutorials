//
//  LandmarkList.swift
//  Landmarks
//
//  Created by SwiftStage on 2025/09/08.
//

import SwiftUI

struct LandmarkList: View {
    
    @Environment(ModelData.self) private var modelData
    
    @State private var selectedLandmarkID: Int? = nil
    @State private var displayingLandmarkIDs: [Int] = []
    @State private var filter = Filter()
    @State private var showingMenu = false
    
    @Binding private(set) var showingProfile: Bool
        
    var filteredLandmarks: Binding<Landmarks> {
        let landmarks = modelData
            .bindingLandmarks
            .filter { landmark in
                displayingLandmarkIDs.contains(landmark.id)
            }
        
        return Binding(landmarks)
    }
    
    func landmark(byID id: Int) -> BindingLandmark? {
        modelData.bindingLandmarks[id: id]
    }
    
    var selectedLandmark: BindingLandmark? {
        guard let selectedLandmarkID else {
            return nil
        }
        return landmark(byID: selectedLandmarkID)
    }
    
    func updateLandmarkList() {
        displayingLandmarkIDs = modelData
            .landmarks
            .lazy
            .filter(filter.matches(_:))
            .map(\.id)
    }
        
    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationSplitView {
            List(selection: $selectedLandmarkID) {
                ForEach(filteredLandmarks, id: \.id) { landmark in
                    listRow(for: landmark)
                }
            }
            .onChange(of: filter) {
                updateLandmarkList()
            }
            .animation(.default, value: filteredLandmarks.map(\.wrappedValue))
            .frame(minWidth: Self.listMinimumWidth)
            #if os(watchOS)
            .listMenu(showingMenu: $showingMenu, showFavoritesOnly: $filter.showFavoritesOnly, showingProfile: $showingProfile)
            .navigationTitle("Landmarks")
            #endif
            #if os(iOS) || os(macOS)
            .navigationTitle(title)
            .profileToolbar($showingProfile)
            .toolbar(content: toolbarContent)
            #endif
        } detail: {
            if let landmark = selectedLandmark {
                LandmarkDetail(landmark: landmark)
            } else {
                Text("Select a Landmark")
            }
        }
        .onAppear {
            updateLandmarkList()
        }
        #if os(macOS) || os(iOS)
        .focusedValue(\.selectedLandmark, selectedLandmark)
        #endif
    }
}

private extension LandmarkList {
    
    #if os(iOS)
    static let listMinimumWidth: CGFloat? = nil
    #endif

    #if os(macOS)
    static let listMinimumWidth: CGFloat? = 300
    #endif
    
    #if os(watchOS)
    static let listMinimumWidth: CGFloat? = nil
    #endif
}

private extension LandmarkList {
    
    @ViewBuilder
    func listRow(for landmark: BindingLandmark) -> some View {
        LandmarkRow(landmark: landmark)
        #if os(watchOS)
            .onTapGesture {
                selectedLandmarkID = landmark.id
            }
        #endif
    }
}
#if os(iOS) || os(macOS)
private extension LandmarkList {
    
    var title: String {
        let title = switch filter.categories {
        case .all:
            "Landmarks"
            
        case .specific(let category):
            String(describing: category)
        }
        
        return filter.showFavoritesOnly ? "Favorite \(title)" : title
    }
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem {
            Menu {
                Picker("Category", selection: $filter.categories) {
                    ForEach(Filter.Categories.allCases) { categories in
                        Text(categories).tag(categories)
                    }
                }
                .pickerStyle(.inline)

                ShowFavoriteOnlyToggle(showFavoritesOnly: $filter.showFavoritesOnly)
            } label: {
                Label("Filter", systemImage: .sliderHorizontal3)
            }
        }
    }
}
#endif

private extension LandmarkList {
        
    struct Filter: Sendable, Hashable {
        var showFavoritesOnly = false

        #if os(iOS) || os(macOS)
        var categories = Filter.Categories.all
        #endif
    }
}

private extension LandmarkList.Filter {
    
    enum Categories: Sendable, Hashable {
        case all
        case specific(Category)
    }
}

private extension LandmarkList.Filter {
    
    func favoriteFilterMatches(_ landmark: Landmark) -> Bool {
        showFavoritesOnly ? landmark.isFavorite : true
    }
    
    #if os(iOS) || os(macOS)
    func categoriesFilterMatches(_ landmark: Landmark) -> Bool {
        switch categories {
        case .all:
            true
            
        case .specific(let category):
            category == landmark.category
        }
    }
    #endif
    
    func matches(_ landmark: Landmark) -> Bool {
        #if os(iOS) || os(macOS)
        favoriteFilterMatches(landmark) && categoriesFilterMatches(landmark)
        #elseif os(watchOS)
        favoriteFilterMatches(landmark)
        #endif
    }
}

extension LandmarkList.Filter.Categories: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .all:
            "All"
            
        case .specific(let category):
            String(describing: category)
        }
    }
}

extension LandmarkList.Filter.Categories: Identifiable {
    
    var id: Self {
        self
    }
}

extension LandmarkList.Filter.Categories: CaseIterable {
    
    static var allSpecifics: [Self] {
        Category
            .allCases
            .map { category in
                .specific(category)
            }
    }
    
    static var allCases: [Self] {
        CollectionOfOne(.all) + allSpecifics
    }
}

private extension LandmarkList {
    
}

private extension Text {
    init(_ categories: LandmarkList.Filter.Categories) {
        self.init(verbatim: String(describing: categories))
    }
}

#Preview {
    @Previewable @State var showingProfile = false
    LandmarkList(showingProfile: $showingProfile)
        .environment(ModelData())
}

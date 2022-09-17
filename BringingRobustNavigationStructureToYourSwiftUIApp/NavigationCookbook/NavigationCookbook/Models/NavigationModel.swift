/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A navigation model used to persist and restore the navigation state.
*/

import SwiftUI
import Combine

final class NavigationModel: ObservableObject, Codable {
    @Published var selectedCategory: Category?
    @Published var recipePath: [Recipe]
    @Published var columnVisibility: NavigationSplitViewVisibility
    
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()

    init(columnVisibility: NavigationSplitViewVisibility = .automatic,
         selectedCategory: Category? = nil,
         recipePath: [Recipe] = []
    ) {
        self.columnVisibility = columnVisibility
        self.selectedCategory = selectedCategory
        self.recipePath = recipePath
    }

    var selectedRecipe: Recipe? {
        get { recipePath.first }
        set { recipePath = [newValue].compactMap { $0 } }
    }

    var jsonData: Data? {
        get { try? encoder.encode(self) }
        set {
            guard let data = newValue,
                  let model = try? decoder.decode(Self.self, from: data)
            else { return }
            selectedCategory = model.selectedCategory
            recipePath = model.recipePath
            columnVisibility = model.columnVisibility
        }
    }

    var objectWillChangeSequence: AsyncPublisher<Publishers.Buffer<ObservableObjectPublisher>> {
        objectWillChange
            .buffer(size: 1, prefetch: .byRequest, whenFull: .dropOldest)
            .values
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedCategory = try container.decodeIfPresent(
            Category.self, forKey: .selectedCategory)
        let recipePathIds = try container.decode(
            [Recipe.ID].self, forKey: .recipePathIds)
        self.recipePath = recipePathIds.compactMap { DataModel.shared[$0] }
        self.columnVisibility = try container.decode(
            NavigationSplitViewVisibility.self, forKey: .columnVisibility)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(selectedCategory, forKey: .selectedCategory)
        try container.encode(recipePath.map(\.id), forKey: .recipePathIds)
        try container.encode(columnVisibility, forKey: .columnVisibility)
    }

    enum CodingKeys: String, CodingKey {
        case selectedCategory
        case recipePathIds
        case columnVisibility
    }
}

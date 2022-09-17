/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A grid of recipe tiles, based on a given recipe category.
*/

import SwiftUI

struct RecipeGrid: View {
    var category: Category?
    var dataModel = DataModel.shared

    var body: some View {
        // Workaround for a known issue where `NavigationSplitView` and
        // `NavigationStack` fail to update when their contents are conditional.
        // For more information, see the iOS 16 Release Notes and
        // macOS 13 Release Notes. (91311311)"
        ZStack {
            if let category = category {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(dataModel.recipes(in: category)) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeTile(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
                .navigationTitle(category.localizedName)
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetail(recipe: recipe) { relatedRecipe in
                        NavigationLink(value: relatedRecipe) {
                            RecipeTile(recipe: relatedRecipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
            } else {
                Text("Choose a category")
                    .navigationTitle("")
            }
        }
    }

    var columns: [GridItem] {
        [ GridItem(.adaptive(minimum: 240)) ]
    }
}

struct RecipeGrid_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Category.allCases) {
            RecipeGrid(category: nil, dataModel: .shared)
            RecipeGrid(category: $0, dataModel: .shared)
        }
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the three-column navigation split view experience.
*/

import SwiftUI

struct ThreeColumnContentView: View {
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared
    var categories = Category.allCases

    var body: some View {
        NavigationSplitView(
            columnVisibility: $navigationModel.columnVisibility
        ) {
            List(
                categories,
                selection: $navigationModel.selectedCategory
            ) { category in
                NavigationLink(category.localizedName, value: category)
            }
            .navigationTitle("Categories")
        } content: {
            // Workaround for a known issue where `NavigationSplitView` and
            // `NavigationStack` fail to update when their contents are conditional.
            // For more information, see the iOS 16 Release Notes and
            // macOS 13 Release Notes. (91311311)"
            ZStack {
                if let category = navigationModel.selectedCategory {
                    List(selection: $navigationModel.selectedRecipe) {
                        ForEach(dataModel.recipes(in: category)) { recipe in
                            NavigationLink(recipe.name, value: recipe)
                        }
                    }
                    .navigationTitle(category.localizedName)
                    .onDisappear {
                        if navigationModel.selectedRecipe == nil {
                            navigationModel.selectedCategory = nil
                        }
                    }
                    .toolbar {
                        ExperienceButton(isActive: $showExperiencePicker)
                    }
                } else {
                    Text("Choose a category")
                        .navigationTitle("")
                }
            }
        } detail: {
            RecipeDetail(recipe: navigationModel.selectedRecipe) { relatedRecipe in
                Button {
                    navigationModel.selectedCategory = relatedRecipe.category
                    navigationModel.selectedRecipe = relatedRecipe
                } label: {
                    RecipeTile(recipe: relatedRecipe)
                }
                .buttonStyle(.plain)
            }
        }
    }

    func showRecipeOfTheDay() {
        let recipe = dataModel.recipeOfTheDay
        navigationModel.selectedCategory = recipe.category
        navigationModel.recipePath = [recipe]
    }
}

struct ThreeColumnContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThreeColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(columnVisibility: .all))
            ThreeColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(
                columnVisibility: .all,
                selectedCategory: .dessert))
            ThreeColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(
                columnVisibility: .all,
                selectedCategory: .dessert,
                recipePath: [.mock]))
        }
    }
}

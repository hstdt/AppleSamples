/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the navigation stack view experience.
*/

import SwiftUI

struct StackContentView: View {
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared

    var body: some View {
        NavigationStack(path: $navigationModel.recipePath) {
            List(Category.allCases) { category in
                Section {
                    ForEach(dataModel.recipes(in: category)) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                } header: {
                    Text(category.localizedName)
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ExperienceButton(isActive: $showExperiencePicker)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe) { relatedRecipe in
                    NavigationLink(value: relatedRecipe) {
                        RecipeTile(recipe: relatedRecipe)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    func showRecipeOfTheDay() {
        navigationModel.recipePath = [dataModel.recipeOfTheDay]
    }

    func showCategories() {
        navigationModel.recipePath.removeAll()
    }
}

struct StackContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackContentView(
            showExperiencePicker: .constant(false),
            dataModel: .shared)
        .environmentObject(NavigationModel())
        
        StackContentView(
            showExperiencePicker: .constant(false),
            dataModel: .shared)
        .environmentObject(NavigationModel(
            selectedCategory: .dessert,
            recipePath: [.mock]))
    }
}

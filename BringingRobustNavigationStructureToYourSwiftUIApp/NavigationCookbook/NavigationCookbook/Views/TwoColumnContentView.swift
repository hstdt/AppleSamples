/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the two-column navigation split view experience.
*/

import SwiftUI

struct TwoColumnContentView: View {
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var categories = Category.allCases
    var dataModel = DataModel.shared

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
            .toolbar {
                ExperienceButton(isActive: $showExperiencePicker)
            }
        } detail: {
            NavigationStack(path: $navigationModel.recipePath) {
                RecipeGrid(category: navigationModel.selectedCategory)
            }
        }
    }
}

struct TwoColumnContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TwoColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(columnVisibility: .doubleColumn))
            TwoColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(
                columnVisibility: .doubleColumn,
                selectedCategory: .dessert))
            TwoColumnContentView(
                showExperiencePicker: .constant(false),
                dataModel: .shared)
            .environmentObject(NavigationModel(
                columnVisibility: .doubleColumn,
                selectedCategory: .dessert,
                recipePath: [.mock]))
        }
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A recipe tile, displaying the recipe's photo and name.
*/

import SwiftUI

struct RecipeTile: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            RecipePhoto(recipe: recipe)
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: 240, maxHeight: 240)
            Text(recipe.name)
                .lineLimit(2, reservesSpace: true)
                .font(.headline)
        }
        .tint(.primary)
    }
}

struct RecipeTile_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTile(recipe: .mock)
    }
}

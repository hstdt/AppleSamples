/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A photo view for a given recipe, displaying the recipe's image or a placeholder.
*/

import SwiftUI

struct RecipePhoto: View {
    var recipe: Recipe

    var body: some View {
        if let imageName = recipe.imageName {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ZStack {
                Rectangle()
                    .fill(.tertiary)
                Image(systemName: "camera")
                    .font(.system(size: 64))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct RecipePhoto_Previews: PreviewProvider {
    static var previews: some View {
        RecipePhoto(recipe: .mock)
    }
}

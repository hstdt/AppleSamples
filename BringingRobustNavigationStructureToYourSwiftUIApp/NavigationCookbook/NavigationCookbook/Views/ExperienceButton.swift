/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An button that presents the navigation experience picker when its action
 is invoked.
*/

import SwiftUI

struct ExperienceButton: View {
    @Binding var isActive: Bool

    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Experience", systemImage: "wand.and.stars")
                .help("Choose your navigation experience")
        }
    }
}

struct ExperienceButton_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceButton(isActive: .constant(false))
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the WWDC22 challenge.
*/

import SwiftUI

struct ChallengeContentView: View {
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared

    var body: some View {
        VStack {
            Text("Put your navigation experience here")
            ExperienceButton(isActive: $showExperiencePicker)
        }
    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView(showExperiencePicker: .constant(false))
    }
}

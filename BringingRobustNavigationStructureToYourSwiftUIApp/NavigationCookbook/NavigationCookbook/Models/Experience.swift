/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An enumeration of navigation experiences used to define the app architecture.
*/

import SwiftUI

enum Experience: Int, Identifiable, CaseIterable, Codable {
    var id: Int { rawValue }

    case stack
    case twoColumn
    case threeColumn
    case challenge

    var imageName: String {
        switch self {
        case .stack: return "list.bullet.rectangle.portrait"
        case .twoColumn: return "sidebar.left"
        case .threeColumn: return "rectangle.split.3x1"
        case .challenge: return "hands.sparkles"
        }
    }
    
    var localizedName: LocalizedStringKey {
        switch self {
        case .stack: return "Stack"
        case .twoColumn: return "Two columns"
        case .threeColumn: return "Three columns"
        case .challenge: return "WWDC22 Challenge"
        }
    }
    
    var localizedDescription: LocalizedStringKey {
        switch self {
        case .stack:
            return "Presents a stack of views over a root view."
        case .twoColumn:
            return "Presents views in two columns: sidebar and detail."
        case .threeColumn:
            return "Presents views in three columns: sidebar, content, and detail."
        case .challenge:
            return "A coding challenge to explore the new navigation architectures."
        }
    }
}

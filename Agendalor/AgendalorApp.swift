//
//  AgendalorApp.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/27.
//

import SwiftUI
import SwiftData

@main
struct AgendalorApp: App {
    let modelContainer = DataModel.shared.modelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentScreen()
        }
    }
}

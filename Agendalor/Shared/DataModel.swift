//
//  DataModel.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI
import SwiftData

actor DataModel {
    struct TransactionAuthor {
        static let widget = "widget"
    }

    static let shared = DataModel()
    private init() {}
    
    nonisolated lazy var modelContainer: ModelContainer = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: Minutes.self)
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }
        return modelContainer
    }()
}

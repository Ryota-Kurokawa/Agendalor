//
//  Minutes.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import Foundation
import SwiftUI
import SwiftData

@Model class Minutes {
    #Index<Minutes>([\.title], [\.createdAt], [\.title, \.createdAt])
    #Unique<Minutes>([\.title, \.createdAt])
    
    var title: String
    var icon: String
    var createdAt: Date
    var agenda: [Agenda]
    
    init(title: String, icon: String, createdAt: Date, agenda: [Agenda]) {
        self.title = title
        self.icon = icon
        self.createdAt = createdAt
        self.agenda = agenda
    }
}

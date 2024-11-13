//
//  Agenda.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import Foundation

struct Agenda: Codable, Hashable {
    var section: String
    var description: String
    
    init(section: String, description: String) {
        self.section = section
        self.description = description
    }
}

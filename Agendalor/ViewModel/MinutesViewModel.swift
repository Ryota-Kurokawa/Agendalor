//
//  MinutesViewModel.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import Foundation

class MinutesViewModel: ObservableObject {
    @Published var minutes: Minutes
    
    init(minutes: Minutes) {
        self.minutes = minutes
    }
    
    func addAgenda(section: String, description: String) {
        let agenda = Agenda(section: section, description: description)
        minutes.agenda.append(agenda)
    }
    
    func removeAgenda(at index: Int) {
        minutes.agenda.remove(at: index)
    }
    
    func updateAgenda(at index: Int, section: String, description: String) {
        minutes.agenda[index].section = section
        minutes.agenda[index].description = description
    }
    
    func saveMinutes() {
        // Save minutes to database
    }
    
    func loadMinutes() {
        // Load minutes from database
    }
}

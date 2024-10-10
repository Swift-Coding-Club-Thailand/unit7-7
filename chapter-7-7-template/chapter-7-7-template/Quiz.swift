//
//  Quiz.swift
//  chapter-7-7-template
//
//  Created by Sanpawat Sewsuwan on 30/6/2567 BE.
//

import Foundation
import Observation

@Observable
class Quiz: Identifiable {
    var id: UUID = UUID()
    var question: String
    var choices: [Choice]
    
    init(question: String, choices: [Choice]) {
        self.question = question
        self.choices = choices
    }
}

//
//  Choice.swift
//  chapter-7-7-template
//
//  Created by Sanpawat Sewsuwan on 30/6/2567 BE.
//

import Foundation
import Observation

@Observable
class Choice: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isAnswered: Bool
    var isSelected: Bool = false
    
    init(title: String, isAnswered: Bool) {
        self.title = title
        self.isAnswered = isAnswered
    }
}

//
//  ChatMessage.swift
//  HelloChat
//
//  Created by KIM MIMI on 9/3/24.
//

import Foundation

enum ChatRole: Int {
    case me
    case other
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
    var time: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시 m분"
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        return formatter.string(from: date)
    }
}


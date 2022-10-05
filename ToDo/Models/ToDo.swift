//
//  ToDo.swift
//  ToDo
//
//  Created by Aleksey Alyonin on 12.06.2022.
//

import SwiftUI
import RealmSwift

class ToDo: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var completed = false
    @Persisted var urgency: Urgency = .neutral

    
    enum Urgency: Int, PersistableEnum {
        case trivial, neutral, urgent
        
        var text: String {
            switch self{
            case .neutral:
                return "neutral"
            case .trivial:
                return "trivial"
            case .urgent:
                return "urgent"
            }
        }
        
        var color: Color {
            switch self {
            case .trivial:
                return .teal
            case .neutral:
                return .secondary
            case .urgent:
                return .red
            }
        }
    }
    
    func increment()-> Urgency {
        switch urgency {
        case .trivial:
            return .neutral
        case .neutral:
            return .urgent
        case .urgent:
            return .trivial
        }
    }
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}


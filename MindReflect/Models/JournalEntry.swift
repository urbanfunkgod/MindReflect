//
//  JournalEntry.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

struct JournalEntry: Identifiable {
    let id: UUID
    let content: String
    let timestamp: Date
    let type: JournalType
    let tags: [String]
    let emotions: [Emotion]
    
    enum JournalType: String, Codable {
        case freeAssociation
        case dream
        case reflection
    }
}

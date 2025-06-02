//
//  Relationship.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

struct Relationship: Identifiable, Codable {
    let id: UUID
    let name: String
    let patterns: [String]
    let influences: [String]
}

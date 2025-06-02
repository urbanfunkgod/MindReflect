//
//  Emotion.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

struct Emotion: Identifiable {
    let id: UUID
    let name: String
    let intensity: Double
    let timestamp: Date
}

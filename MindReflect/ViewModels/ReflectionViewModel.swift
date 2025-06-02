//
//  ReflectionViewModel.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

class ReflectionViewModel: ObservableObject {
    @Published var relationships: [Relationship] = []
    @Published var patterns: [String] = []
    
    private let journalViewModel: JournalViewModel
    
    init(journalViewModel: JournalViewModel) {
        self.journalViewModel = journalViewModel
        analyzePatterns()
    }
    
    func analyzePatterns() {
        // Analyze journal entries for recurring themes or patterns
        let entries = journalViewModel.journalEntries
        var tagCounts: [String: Int] = [:]
        
        for entry in entries {
            for tag in entry.tags {
                tagCounts[tag, default: 0] += 1
            }
        }
        
        // Identify tags that appear frequently (e.g., more than 2 times)
        patterns = tagCounts.filter { $0.value > 2 }.map { $0.key }
        
        // Placeholder for relationship analysis
        relationships = [
            Relationship(id: UUID(), name: "Family", patterns: patterns, influences: ["Stress", "Support"])
        ]
    }
}

//
//  JournalViewModel.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import Foundation

class JournalViewModel: ObservableObject {
@Published var journalEntries: [JournalEntry] = []
private let coreDataManager = CoreDataManager()

func loadEntries() {
journalEntries = coreDataManager.fetchEntries()
}

func saveEntry(content: String, type: JournalEntry.JournalType, tags: [String]) {
let newEntry = JournalEntry(
id: UUID(),
content: content,
timestamp: Date(),
type: type,
tags: tags,
emotions: []
)
coreDataManager.saveEntry(newEntry)
loadEntries()
}
}

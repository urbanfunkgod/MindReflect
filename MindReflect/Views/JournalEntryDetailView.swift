//
//  JournalEntryDetailView.swift
//  MindReflect
//
//  Created by Johann Flores on 6/2/25.
//
import SwiftUI

struct JournalEntryDetailView: View {
let entry: JournalEntry

var body: some View {
ZStack {
LinearGradient(
gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]),
startPoint: .top,
endPoint: .bottom
)
.ignoresSafeArea()

ScrollView {
VStack(alignment: .leading, spacing: 20) {
Text("Entry Details")
.font(DesignConstants.headlineFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.bottom, 10)

Text(entry.timestamp, style: .date)
.font(DesignConstants.captionFont)
.foregroundColor(DesignConstants.secondaryText)

Text("Type: \(entry.type.rawValue.capitalized)")
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)

Text("Content:")
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
.bold()

Text(entry.content)
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.bottom, 10)

if !entry.tags.isEmpty {
Text("Tags:")
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
.bold()

HStack {
ForEach(entry.tags, id: .self) { tag in
Text(tag)
.font(DesignConstants.captionFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.horizontal, 10)
.padding(.vertical, 5)
.background(DesignConstants.accentColor.opacity(0.2))
.cornerRadius(8)
}
}
}

if !entry.emotions.isEmpty {
Text("Emotions:")
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
.bold()

ForEach(entry.emotions, id: .id) { emotion in
HStack {
Text(emotion.name.capitalized)
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
Spacer()
Text("Intensity: \(emotion.intensity.description)")
.font(DesignConstants.captionFont)
.foregroundColor(DesignConstants.secondaryText)
}
}
}
}
.padding()
.background(DesignConstants.glassBackground)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(
color: DesignConstants.shadowColor,
radius: DesignConstants.shadowRadius,
x: DesignConstants.shadowOffset.x,
y: DesignConstants.shadowOffset.y
)
.padding()
}
.navigationTitle("Journal Entry")
.navigationBarTitleDisplayMode(.inline)
}
}
}

struct JournalEntryDetailView_Previews: PreviewProvider {
static var previews: some View {
NavigationView {
JournalEntryDetailView(entry: JournalEntry(
id: UUID(),
content: "This is a sample journal entry.",
timestamp: Date(),
type: .reflection,
tags: ["thoughts", "emotions"],
emotions: [
Emotion(id: UUID(), name: "happy", intensity: 0.8, timestamp: Date()),
Emotion(id: UUID(), name: "calm", intensity: 0.6, timestamp: Date())
]
))
}
}
}

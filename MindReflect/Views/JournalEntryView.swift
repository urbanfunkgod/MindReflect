//
//  JournalEntryView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

struct JournalEntryView: View {
@ObservedObject var journalViewModel: JournalViewModel
@Environment(\.dismiss) private var dismiss
@State private var content: String = ""
@State private var selectedQuestion: String? = nil
@State private var selectedType: EntryType = .reflection
@State private var tagInput: String = ""

enum EntryType {
    case reflection, dream, freewrite
}

private let reflectionQuestions: [String] = [
"What are you grateful for today?",
"What challenged you today?",
"What did you learn today?",
"How did you feel today?",
"What inspired you today?",
"What’s a goal you want to focus on tomorrow?"
]

var body: some View {
ZStack {
LinearGradient(
gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]),
startPoint: .top,
endPoint: .bottom
)
.ignoresSafeArea()

VStack(spacing: 20) {
Text("New Journal Entry")
.font(DesignConstants.headlineFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.top, 20)

ScrollView(.horizontal, showsIndicators: false) {
HStack(spacing: 10) {
ForEach(reflectionQuestions, id: .self) { question in
Button(action: {
selectedQuestion = question
content = question + "\n\n"
}) {
Text(question)
.font(DesignConstants.captionFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.horizontal, 15)
.padding(.vertical, 10)
.background(DesignConstants.glassBackground)
.shadow(
color: DesignConstants.shadowColor,
radius: DesignConstants.shadowRadius,
x: DesignConstants.shadowOffset.x,
y: DesignConstants.shadowOffset.y
)
}
}
}
.padding(.horizontal)
}
.padding(.vertical, 10)

Picker("Entry Type", selection: $selectedType) {
    Text("Reflection").tag(EntryType.reflection)
    Text("Dream").tag(EntryType.dream)
    Text("Freewrite").tag(EntryType.freewrite)
}
.pickerStyle(SegmentedPickerStyle())
.padding(.horizontal)

TextField("Add tags (comma-separated)", text: $tagInput)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding(.horizontal)

ZStack(alignment: .topLeading) {
TextEditor(text: $content)
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)

if content.isEmpty {
Text("Start writing here...")
.foregroundColor(.gray)
.padding(.top, 8)
.padding(.horizontal, 5)
}
}
.frame(minHeight: 200)
.padding()
.background(DesignConstants.glassBackground)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(
color: DesignConstants.shadowColor,
radius: DesignConstants.shadowRadius,
x: DesignConstants.shadowOffset.x,
y: DesignConstants.shadowOffset.y
)
.padding(.horizontal)

Button("Clear") {
    content = ""
}
.foregroundColor(.red)
.padding(.bottom, 5)

Button(action: {
if !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
    let tags = tagInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    journalViewModel.saveEntry(content: content, type: selectedType, tags: tags)
    dismiss()
}
}) {
Text("Save Entry")
.font(.custom("SFProText-Medium", size: 16))
.frame(maxWidth: .infinity)
.padding(.vertical, 12)
.background(DesignConstants.glassBackground)
.foregroundColor(DesignConstants.primaryText)
.shadow(
color: DesignConstants.shadowColor,
radius: DesignConstants.shadowRadius,
x: DesignConstants.shadowOffset.x,
y: DesignConstants.shadowOffset.y
)
}
.padding(.horizontal)
.padding(.bottom, 20)
}
.padding(.vertical)
.background(DesignConstants.glassBackground)
.navigationTitle("New Journal Entry")
.navigationBarTitleDisplayMode(.inline)
.toolbar {
Button("Cancel") {
dismiss()
}
.foregroundColor(DesignConstants.accentColor)
}
}
}
}

struct JournalEntryView_Previews: PreviewProvider {
static var previews: some View {
NavigationView {
JournalEntryView(journalViewModel: JournalViewModel(previewMode: true))
}
}
}

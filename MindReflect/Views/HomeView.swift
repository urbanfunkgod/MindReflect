//
//  HomeView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

struct HomeView: View {
@StateObject private var journalViewModel = JournalViewModel()
@State private var showingJournalEntryView = false
@State private var showingDreamJournalView = false

var body: some View {
NavigationView {
ZStack {
// Background with subtle gradient
LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

VStack(spacing: 20) {
Text("Welcome to MindReflect")
.font(DesignConstants.headlineFont)
.foregroundColor(DesignConstants.primaryText)
.padding(.top, 20)

NavigationLink(destination: CalendarView()) {
Text("View Calendar")
.font(.custom("SFProText-Medium", size: 16))
.frame(maxWidth: .infinity)
.padding(.vertical, 12)
.background(DesignConstants.glassBackground)
.foregroundColor(DesignConstants.primaryText)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
}
.background(VisualEffectBlur(blurStyle: DesignConstants.blurStyle))
.cornerRadius(DesignConstants.cornerRadius)

Button(action: {
showingJournalEntryView = true
}) {
Text("New Journal Entry")
.font(.custom("SFProText-Medium", size: 16))
.frame(maxWidth: .infinity)
.padding(.vertical, 12)
.background(DesignConstants.glassBackground)
.foregroundColor(DesignConstants.primaryText)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
}
.background(VisualEffectBlur(blurStyle: DesignConstants.blurStyle))
.cornerRadius(DesignConstants.cornerRadius)
.sheet(isPresented: $showingJournalEntryView) {
JournalEntryView(journalViewModel: journalViewModel)
}

Button(action: {
showingDreamJournalView = true
}) {
Text("Record a Dream")
.font(.custom("SFProText-Medium", size: 16))
.frame(maxWidth: .infinity)
.padding(.vertical, 12)
.background(DesignConstants.glassBackground)
.foregroundColor(DesignConstants.primaryText)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
}
.background(VisualEffectBlur(blurStyle: DesignConstants.blurStyle))
.cornerRadius(DesignConstants.cornerRadius)
.sheet(isPresented: $showingDreamJournalView) {
DreamJournalView(journalViewModel: journalViewModel)
}

ScrollView {
ForEach(journalViewModel.journalEntries) { entry in
NavigationLink(destination: JournalEntryDetailView(entry: entry)) {
VStack(alignment: .leading, spacing: 8) {
Text(entry.content)
.font(DesignConstants.bodyFont)
.foregroundColor(DesignConstants.primaryText)
.lineLimit(2)
Text(entry.timestamp, style: .date)
.font(DesignConstants.captionFont)
.foregroundColor(DesignConstants.secondaryText)
}
.padding(.vertical, 12)
.padding(.horizontal, 16)
.frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
.background(DesignConstants.glassBackground)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
}
.background(VisualEffectBlur(blurStyle: DesignConstants.blurStyle))
.cornerRadius(DesignConstants.cornerRadius)
.padding(.horizontal, 16)
.padding(.vertical, 4)
}
}
}
.padding(.horizontal, 16)
.padding(.vertical)
.background(DesignConstants.glassBackground)
.navigationTitle("Home")
.toolbar {
NavigationLink(destination: SettingsView()) {
Image(systemName: "gear")
.foregroundColor(DesignConstants.accentColor)
}
}
.onAppear {
journalViewModel.loadEntries()
}
}
}
}
}

struct HomeView_Previews: PreviewProvider {
static var previews: some View {
HomeView()
}
}

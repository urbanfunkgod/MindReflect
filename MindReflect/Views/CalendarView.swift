//
//  CalendarView.swift
//  MindReflect
//
//  Created by Johann Flores on 6/2/25.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = JournalViewModel()
    @State private var selectedDate = Date()

    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    // Struct to pair index with date
    private struct IndexedDate: Identifiable {
        let id: Int
        let date: Date?
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Month Navigation
                HStack {
                    Button(action: {
                        if let newDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) {
                            selectedDate = newDate
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(DesignConstants.accentColor)
                    }

                    Text(dateFormatter.string(from: selectedDate))
                        .font(DesignConstants.headlineFont)
                        .foregroundColor(DesignConstants.primaryText)
                        .frame(maxWidth: .infinity)

                    Button(action: {
                        if let newDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) {
                            selectedDate = newDate
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(DesignConstants.accentColor)
                    }
                }
                .padding()
                .background(DesignConstants.glassBackground)
                .cornerRadius(DesignConstants.cornerRadius)
                .padding(.horizontal)

                // Days Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                        Text(day)
                            .font(DesignConstants.captionFont)
                            .foregroundColor(DesignConstants.secondaryText)
                            .frame(maxWidth: .infinity)
                    }

                    ForEach(indexedDates(), id: \.id) { indexedDate in
                        if let day = indexedDate.date {
                            let hasEntries = viewModel.journalEntries.contains { calendar.isDate($0.timestamp, inSameDayAs: day) }
                            Button(action: {
                                selectedDate = day
                            }) {
                                Text("\(calendar.component(.day, from: day))")
                                    .font(DesignConstants.bodyFont)
                                    .foregroundColor(hasEntries ? DesignConstants.accentColor : DesignConstants.primaryText)
                                    .frame(width: 40, height: 40)
                                    .background(
                                        calendar.isDate(selectedDate, inSameDayAs: day)
                                        ? DesignConstants.accentColor.opacity(0.2)
                                        : Color.clear
                                    )
                                    .clipShape(Circle())
                            }
                        } else {
                            Color.clear
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()
                .background(DesignConstants.glassBackground)
                .cornerRadius(DesignConstants.cornerRadius)
                .padding(.horizontal)

                // Entry List
                ScrollView {
                    let entriesForDate = viewModel.journalEntries.filter {
                        calendar.isDate($0.timestamp, inSameDayAs: selectedDate)
                    }

                    if entriesForDate.isEmpty {
                        Text("No entries for \(dateFormatter.string(from: selectedDate))")
                            .font(DesignConstants.bodyFont)
                            .foregroundColor(DesignConstants.secondaryText)
                            .padding()
                    } else {
                        ForEach(entriesForDate, id: \.id) { entry in
                            NavigationLink(destination: JournalEntryDetailView(entry: entry)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(entry.content)
                                        .font(DesignConstants.bodyFont)
                                        .foregroundColor(DesignConstants.primaryText)
                                        .lineLimit(2)

                                    Text(entry.timestamp, style: .time)
                                        .font(DesignConstants.captionFont)
                                        .foregroundColor(DesignConstants.secondaryText)
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                                .background(DesignConstants.glassBackground)
                                .cornerRadius(DesignConstants.cornerRadius)
                                .shadow(
                                    color: DesignConstants.shadowColor,
                                    radius: DesignConstants.shadowRadius,
                                    x: DesignConstants.shadowOffset.x,
                                    y: DesignConstants.shadowOffset.y
                                )
                            }
                            .background(DesignConstants.glassBackground) // Replaced VisualEffectBlur
                            .cornerRadius(DesignConstants.cornerRadius)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(.top)
                .background(DesignConstants.glassBackground)
                .cornerRadius(DesignConstants.cornerRadius)
                .padding(.horizontal)
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadEntries()
            }
        }
    }

    private func daysInMonth() -> [Date?] {
        let components = calendar.dateComponents([.year, .month], from: selectedDate)
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }

        let firstDayOfMonth = calendar.component(.weekday, from: startOfMonth)
        let offset = (firstDayOfMonth - calendar.firstWeekday + 7) % 7
        let days = (0..<range.count).map { day -> Date in
            calendar.date(byAdding: .day, value: day, to: startOfMonth)!
        }

        return Array(repeating: nil, count: offset)
            + days
            + Array(repeating: nil, count: 42 - (offset + range.count))
    }

    private func indexedDates() -> [IndexedDate] {
        daysInMonth().enumerated().map { index, date in
            IndexedDate(id: index, date: date)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarView()
        }
    }
}

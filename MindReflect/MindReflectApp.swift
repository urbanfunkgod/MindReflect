//
//  MindReflectApp.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//

import SwiftUI

@main
struct MindReflectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

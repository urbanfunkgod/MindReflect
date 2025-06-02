//
//  MindReflectApp.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

@MainActor
@main
struct MindReflectApp: App {
    @StateObject private var authViewModel = AuthenticationViewModel()
    @State private var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    init() {
        // Register the custom transformer
        StringArrayTransformer.register()
    }
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                if authViewModel.isAuthenticated {
                    HomeView()
                } else {
                    AuthenticationView()
                        .environmentObject(authViewModel)
                }
            } else {
                OnboardingView {
                    hasCompletedOnboarding = true
                }
            }
        }
    }
}

//
//  AuthenticationViewModel.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import LocalAuthentication
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    private var autoLockTimer: Timer?
    
    func authenticate() {
        let context = LAContext()
        // Check if running in a simulator for testing purposes
        #if targetEnvironment(simulator)
        // Bypass FaceID in simulator for testing
        print("Simulator detected: Bypassing FaceID for testing")
        DispatchQueue.main.async {
            self.isAuthenticated = true
            self.errorMessage = nil
        }
        return
        #endif
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: "Access your journal") { success, error in
            DispatchQueue.main.async {
                if success {
                    self.isAuthenticated = true
                    self.errorMessage = nil
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Authentication failed"
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func setupAutoLock(timeout: TimeInterval) {
        autoLockTimer?.invalidate()
        autoLockTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { _ in
            DispatchQueue.main.async {
                self.isAuthenticated = false
            }
        }
    }
}

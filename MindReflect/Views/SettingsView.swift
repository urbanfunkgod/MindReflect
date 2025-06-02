//
//  SettingsView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    @State private var autoLockTimeout = 300.0
    
    var body: some View {
        Form {
            Section(header: Text("Privacy")
                .foregroundColor(Color("TextPrimary"))) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    .font(.custom("SFProText-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary"))
                Slider(value: $autoLockTimeout, in: 60...600, step: 60) {
                    Text("Auto-Lock Timeout (seconds)")
                        .font(.custom("SFProText-Regular", size: 16))
                        .foregroundColor(Color("TextPrimary"))
                }
                Text("Auto-Lock: \(Int(autoLockTimeout)) seconds")
                    .font(.custom("SFProText-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))
            }
            
            Section(header: Text("Data Management")
                .foregroundColor(Color("TextPrimary"))) {
                Button("Export Data") {
                    // Placeholder for exporting data
                }
                .font(.custom("SFProText-Regular", size: 16))
                .foregroundColor(Color("PrimaryBlue"))
                
                Button("Delete All Data", role: .destructive) {
                    // Placeholder for deleting data
                }
                .font(.custom("SFProText-Regular", size: 16))
            }
            
            Section(header: Text("Legal")
                .foregroundColor(Color("TextPrimary"))) {
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("Privacy Policy")
                        .font(.custom("SFProText-Regular", size: 16))
                        .foregroundColor(Color("PrimaryBlue"))
                }
            }
        }
        .navigationTitle("Settings")
        .onChange(of: notificationsEnabled) { newValue in
            UserDefaults.standard.set(newValue, forKey: "notificationsEnabled")
        }
        .background(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}

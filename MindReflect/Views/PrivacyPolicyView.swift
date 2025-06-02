//
//  PrivacyPolicyView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Privacy Policy")
                    .font(.custom("SFProDisplay-Bold", size: 24)) // SF Pro Display for headings
                    .foregroundColor(Color("TextPrimary")) // #333333
                    .padding(.bottom)
                
                Text("Your journal entries are stored only on your device and never shared. We use strong encryption to keep them safe.")
                    .font(.custom("SFProText-Regular", size: 16)) // SF Pro Text for body
                    .foregroundColor(Color("TextPrimary")) // #333333
                
                Text("No data is collected or transmitted to any external servers. All data remains local to your device.")
                    .font(.custom("SFProText-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary")) // #333333
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .background(Color.white) // #FFFFFF for main background
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrivacyPolicyView()
        }
    }
}

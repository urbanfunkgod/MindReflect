//
//  AuthenticationView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
@EnvironmentObject var authViewModel: AuthenticationViewModel
@State private var iconScale: CGFloat = 1.0

var body: some View {
ZStack {
LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

VStack {
Image(systemName: "faceid")
.resizable()
.scaledToFit()
.frame(width: 60, height: 60)
.foregroundColor(DesignConstants.accentColor)
.scaleEffect(iconScale)
.onAppear {
withAnimation(.spring(response: 0.5, dampingFraction: 0.6).repeatForever(autoreverses: true)) {
iconScale = 1.1
}
}
.padding(.bottom, 20)

Text("Please authenticate to access your journal")
.font(DesignConstants.headlineFont)
.foregroundColor(DesignConstants.primaryText)
.multilineTextAlignment(.center)
.padding()

Button(action: {
authViewModel.authenticate()
}) {
Text("Authenticate with FaceID")
.font(.custom("SFProText-Medium", size: 16))
.frame(maxWidth: .infinity)
.padding()
.background(DesignConstants.glassBackground)
.foregroundColor(DesignConstants.primaryText)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
}
.background(VisualEffectBlur(blurStyle: DesignConstants.blurStyle))
.cornerRadius(DesignConstants.cornerRadius)
.padding()

    if authViewModel.errorMessage != nil {
Text("Error: (error)")
.font(DesignConstants.captionFont)
.foregroundColor(Color("ErrorRed"))
.padding()
}
}
.padding()
.background(DesignConstants.glassBackground)
.cornerRadius(DesignConstants.cornerRadius)
.shadow(color: DesignConstants.shadowColor, radius: DesignConstants.shadowRadius, x: DesignConstants.shadowOffset.x, y: DesignConstants.shadowOffset.y)
.padding()
}
}
}

struct AuthenticationView_Previews: PreviewProvider {
static var previews: some View {
AuthenticationView()
.environmentObject(AuthenticationViewModel())
}
}

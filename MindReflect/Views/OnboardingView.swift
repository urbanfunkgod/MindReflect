//
//  OnboardingView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var notificationsEnabled = false
    @State private var hasCompletedOnboarding = false
    @State private var buttonScale: CGFloat = 1.0 // For button animation
    @State private var dragOffset: CGFloat = 0 // For swipe navigation
    
    private let steps = 5 // 5 steps in onboarding
    private let swipeThreshold: CGFloat = 50 // Minimum swipe distance to trigger navigation
    
    var onComplete: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Welcome Message and Title for Step 1
                if currentStep == 0 {
                    Text("Welcome to")
                        .font(.custom("SFProDisplay-Extrabold", size: 30)) // 30px, ExtraBold
                        .foregroundColor(Color(hex: "#3D4966")) // #3D4966
                        .padding(.top, 40)
                    
                    Text("MindReflect")
                        .font(.custom("SFProDisplay-Extrabold", size: 54)) // 54px, ExtraBold
                        .foregroundColor(Color(hex: "#5D6A85")) // #5D6A85
                        .padding(.bottom, 20)
                }
                
                // Top Section: Full-width Image
                ZStack {
                    switch currentStep {
                    case 0:
                        Image("OnboardingStep1Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Use .fit to prevent clipping
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20, corners: [.bottomLeft, .bottomRight]))
                    case 1:
                        Image("OnboardingStep2Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20, corners: [.bottomLeft, .bottomRight]))
                    case 2:
                        Image("OnboardingStep3Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20, corners: [.bottomLeft, .bottomRight]))
                    case 3:
                        Image("OnboardingStep4Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20, corners: [.bottomLeft, .bottomRight]))
                    case 4:
                        Image("OnboardingStep5Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20, corners: [.bottomLeft, .bottomRight]))
                    default:
                        Color.clear
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, currentStep == 0 ? 0 : 20) // Reduced padding for Steps 2-5
                .padding(.horizontal, 16) // Added padding to prevent image bleeding
                
                Spacer() // Push content to the bottom
                
                // Content for All Steps
                switch currentStep {
                case 0:
                    // Step 1: Welcome to MindReflect
                    EmptyView() // No additional title or body text here
                case 1:
                    // Step 2: Your Privacy Matters
                    Text("Your Privacy Matters")
                        .font(.custom("SFProDisplay-Extrabold", size: 30)) // 30px, ExtraBold
                        .foregroundColor(Color(hex: "#3D4966")) // #3D4966
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("In mental health, your most personal thoughts and feelings deserve absolute protection.")
                        .font(.custom("SFProText-Medium", size: 18)) // 18px, Medium
                        .foregroundColor(Color(hex: "#5D6A85")) // #5D6A85
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                case 2:
                    // Step 3: Your Reflections, Your Privacy
                    Text("Your Reflections, Your Privacy")
                        .font(.custom("SFProDisplay-Extrabold", size: 30)) // 30px, ExtraBold
                        .foregroundColor(Color(hex: "#3D4966")) // #3D4966
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("MindReflect changes that worry—your data stays completely private, stored locally on your device. Only you can access or share your reflections, giving you full control and peace of mind.")
                        .font(.custom("SFProText-Medium", size: 18)) // 18px, Medium
                        .foregroundColor(Color(hex: "#5D6A85")) // #5D6A85
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                case 3:
                    // Step 4: Explore Your Inner World
                    Text("Explore Your Inner World")
                        .font(.custom("SFProDisplay-Extrabold", size: 30)) // 30px, ExtraBold
                        .foregroundColor(Color(hex: "#3D4966")) // #3D4966
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("MindReflect uses psychodynamic principles to explore your unconscious thoughts, dreams, and relationships.")
                        .font(.custom("SFProText-Medium", size: 18)) // 18px, Medium
                        .foregroundColor(Color(hex: "#5D6A85")) // #5D6A85
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                case 4:
                    // Step 5: Understand Yourself Better
                    Text("Understand yourself better.")
                        .font(.custom("SFProDisplay-Extrabold", size: 30)) // 30px, ExtraBold
                        .foregroundColor(Color(hex: "#3D4966")) // #3D4966
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("Reflect deeply to uncover patterns and promote emotional growth. Journal freely, record your dreams, and connect your feelings to past experiences.")
                        .font(.custom("SFProText-Medium", size: 18)) // 18px, Medium
                        .foregroundColor(Color(hex: "#5D6A85")) // #5D6A85
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                default:
                    EmptyView()
                }
                
                Spacer() // Push button and step indicator to the bottom
                
                // Navigation Button (Consistent Position Across All Steps)
                Button(action: {
                    if currentStep < steps - 1 {
                        currentStep += 1
                    } else {
                        // Save onboarding completion and notification preference
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
                        hasCompletedOnboarding = true
                        onComplete()
                    }
                    withAnimation {
                        buttonScale = 0.95
                    }
                }) {
                    Text(currentStep == 0 ? "Let's Get Started" : (currentStep == steps - 1 ? "Get Started" : "Next"))
                        .font(.custom("SFProText-Medium", size: 18))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color("PrimaryBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(buttonScale)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                // Step Indicator (Consistent Position Across All Steps)
                HStack(spacing: 10) {
                    ForEach(0..<steps, id: \.self) { index in
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(index == currentStep ? Color("PrimaryBlue") : .clear)
                            .overlay(
                                Circle()
                                    .stroke(index == currentStep ? Color("PrimaryBlue") : Color.gray.opacity(0.3), lineWidth: 2)
                            )
                            .scaleEffect(index == currentStep ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: currentStep)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 30) // Anchor to bottom with consistent padding
            }
            .padding(.top, 60) // Increased top padding to avoid overlap with Skip/Back button
            .background(Color.white)
            .offset(x: dragOffset) // Apply drag offset for swipe navigation
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.width < -swipeThreshold && currentStep < steps - 1 {
                                // Swipe left to go to the next step
                                currentStep += 1
                            } else if value.translation.width > swipeThreshold && currentStep > 0 {
                                // Swipe right to go to the previous step
                                currentStep -= 1
                            }
                            dragOffset = 0
                        }
                    }
            )
            
            // "Skip"/"Back" Button at Top Right
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        if currentStep == 0 {
                            // Skip onboarding
                            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
                            hasCompletedOnboarding = true
                            onComplete()
                        } else {
                            // Go back to the previous step
                            currentStep -= 1
                        }
                        withAnimation {
                            buttonScale = 1.0
                        }
                    }) {
                        Text(currentStep == 0 ? "Skip" : "Back")
                            .font(.custom("SFProText-Medium", size: 16))
                            .foregroundColor(Color("TextPrimary"))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.top, 40) // Increased top padding for better spacing
                    .padding(.trailing, 16)
                }
                Spacer()
            }
        }
    }
}

// Extension for RoundedRectangle to specify corners
struct RoundedRectangle: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}

// Extension to support hex color codes
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onComplete: {})
    }
}

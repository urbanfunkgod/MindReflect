//
//  DesignConstants.swift
//  MindReflect
//
//  Created by Johann Flores on 6/2/25.
//
import SwiftUI

struct DesignConstants {
// Colors
static let glassBackground = Color.white.opacity(0.3)
static let primaryText = Color.white
static let secondaryText = Color.gray.opacity(0.8)
static let accentColor = Color("PrimaryBlue")

// Corner Radius
static let cornerRadius: CGFloat = 15

// Shadows
static let shadowColor = Color.black.opacity(0.2)
static let shadowRadius: CGFloat = 5
static let shadowOffset: (x: CGFloat, y: CGFloat) = (0, 2)

// Typography
static let headlineFont = Font.custom("SFProDisplay-Bold", size: 24)
static let bodyFont = Font.custom("SFProText-Regular", size: 16)
static let captionFont = Font.custom("SFProText-Regular", size: 14)

// Blur Style for Glass
static let blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial
}

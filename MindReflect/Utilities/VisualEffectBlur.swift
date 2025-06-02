//
//  VisualEffectBlur.swift
//  MindReflect
//
//  Created by Johann Flores on 6/2/25.
//
import SwiftUI

struct VisualEffectBlur: UIViewRepresentable {
let blurStyle: UIBlurEffect.Style

func makeUIView(context: Context) -> UIVisualEffectView {
let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
return view
}

func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
uiView.effect = UIBlurEffect(style: blurStyle)
}
}

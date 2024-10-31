//
//  KeyboardShortcut.swift
//  PromptLib App
//
//  Created by Razi Syed on 10/31/24.
//


import SwiftUI

struct KeyboardShortcut: ViewModifier {
    let key: KeyEquivalent
    let modifiers: EventModifiers
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                Button("") {
                    action()
                }
                .keyboardShortcut(key, modifiers: modifiers)
                .opacity(0)
            )
    }
}

extension View {
    func onKeyboardShortcut(
        key: KeyEquivalent,
        modifiers: EventModifiers = .command,
        action: @escaping () -> Void
    ) -> some View {
        modifier(KeyboardShortcut(key: key, modifiers: modifiers, action: action))
    }
} 
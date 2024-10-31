//
//  PresentationState.swift
//  PromptLib App
//
//  Created by Razi Syed on 10/31/24.
//


import SwiftUI

enum PresentationState: Identifiable {
    case commandMenu
    case newPrompt
    
    var id: Self { self }
} 
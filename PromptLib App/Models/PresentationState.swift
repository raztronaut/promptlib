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
    case editPrompt(Prompt)
    
    var id: String {
        switch self {
        case .commandMenu: return "commandMenu"
        case .newPrompt: return "newPrompt"
        case .editPrompt(let prompt): return "editPrompt-\(prompt.id)"
        }
    }
} 

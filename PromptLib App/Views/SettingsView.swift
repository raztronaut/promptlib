//
//  SettingsView.swift
//  PromptLib App
//
//  Created by Razi Syed on 10/31/24.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("promptsFilePath") private var promptsFilePath: String = ""
    
    var body: some View {
        Form {
            Section("Storage Location") {
                HStack {
                    TextField("Prompts file location", text: .constant(promptsFilePath))
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Choose...") {
                        selectFileLocation()
                    }
                }
            }
        }
        .padding()
        .frame(width: 400, height: 150)
    }
    
    private func selectFileLocation() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        
        if panel.runModal() == .OK {
            promptsFilePath = panel.url?.path ?? ""
        }
    }
} 
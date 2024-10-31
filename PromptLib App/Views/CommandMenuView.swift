import SwiftUI

struct CommandMenuView: View {
    @Binding var presentationState: PresentationState?
    @Binding var selectedPrompt: Prompt?
    @State private var showDeleteConfirmation = false
    @State private var searchText = ""
    @State private var selectedIndex: Int?
    @ObservedObject var viewModel: PromptLibraryViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Search field
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search for actions...", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding()
            .background(.ultraThinMaterial)
            
            // Actions list
            List(selection: $selectedIndex) {
                Group {
                    ActionButton(
                        title: "Copy Prompt",
                        icon: "doc.on.doc",
                        shortcut: "⌘C"
                    ) {
                        // Copy action
                        presentationState = nil
                    }
                    
                    ActionButton(
                        title: "Paste Prompt in Active App",
                        icon: "doc.on.clipboard",
                        shortcut: "⌘V"
                    ) {
                        // Paste action
                        presentationState = nil
                    }
                    
                    ActionButton(
                        title: "Show Prompt",
                        icon: "eye",
                        shortcut: "D"
                    ) {
                        // Show action
                        presentationState = nil
                    }
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .background(.ultraThinMaterial)
        }
        .frame(width: 380, height: 300)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .onDisappear {
            selectedIndex = nil
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let shortcut: String
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 24)
                Text(title)
                Spacer()
                Text(shortcut)
                    .foregroundColor(.secondary)
            }
            .contentShape(Rectangle())
            .padding(.vertical, 4)
            .background(isHovered ? Color.accentColor.opacity(0.2) : Color.clear)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

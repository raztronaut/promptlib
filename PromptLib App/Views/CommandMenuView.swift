import SwiftUI

enum CommandMenuItem: Int {
    case newPrompt
    case share
    case favorite
    case edit
    case delete
}

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let shortcut: String
    let isDestructive: Bool
    let menuItem: CommandMenuItem
    let action: () -> Void
}

struct CommandMenuView: View {
    @Binding var presentationState: PresentationState?
    @Binding var selectedPrompt: Prompt?
    @State private var showDeleteConfirmation = false
    @State private var searchText = ""
    @State private var selectedIndex: CommandMenuItem?
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
                ForEach(createMenuItems()) { item in
                    ActionButton(
                        title: item.title,
                        icon: item.icon,
                        shortcut: item.shortcut,
                        isDestructive: item.isDestructive,
                        action: item.action
                    )
                    .tag(item.menuItem)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .background(.ultraThinMaterial)
        }
        .frame(width: 380, height: 300)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .alert("Delete Prompt", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let prompt = selectedPrompt {
                    viewModel.deletePrompt(prompt)
                    selectedPrompt = nil
                }
                presentationState = nil
            }
        } message: {
            Text("Are you sure you want to delete this prompt? This action cannot be undone.")
        }
        .onDisappear {
            selectedIndex = nil
        }
    }
    
    private func createMenuItems() -> [MenuItem] {
        var items = [
            MenuItem(
                title: "New Prompt",
                icon: "plus.square",
                shortcut: "N",
                isDestructive: false,
                menuItem: .newPrompt
            ) {
                presentationState = .newPrompt
            }
        ]
        
        if let prompt = selectedPrompt {
            items += [
                MenuItem(
                    title: "Share Prompt",
                    icon: "square.and.arrow.up",
                    shortcut: "S",
                    isDestructive: false,
                    menuItem: .share
                ) {
                    sharePrompt(prompt.content)
                },
                MenuItem(
                    title: "Add to Favorites",
                    icon: "star",
                    shortcut: "F",
                    isDestructive: false,
                    menuItem: .favorite
                ) {
                    viewModel.toggleFavorite(prompt)
                    presentationState = nil
                },
                MenuItem(
                    title: "Edit Prompt",
                    icon: "pencil",
                    shortcut: "E",
                    isDestructive: true,
                    menuItem: .edit
                ) {
                    presentationState = .editPrompt(prompt)
                },
                MenuItem(
                    title: "Delete Prompt",
                    icon: "trash",
                    shortcut: "⌫",
                    isDestructive: true,
                    menuItem: .delete
                ) {
                    showDeleteConfirmation = true
                }
            ]
        }
        
        return items
    }
    
    private func sharePrompt(_ content: String) {
        let picker = NSSharingServicePicker(items: [content])
        if let window = NSApp.windows.first {
            picker.show(relativeTo: .zero, of: window.contentView!, preferredEdge: .minY)
        }
        presentationState = nil
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let shortcut: String
    var isDestructive: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Label(title, systemImage: icon)
                Spacer()
                Text(shortcut)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(isDestructive ? .red : .primary)
        }
    }
} 

import SwiftUI

struct ContentView: View {
    @Environment(\.isSidebarVisible) private var isSidebarVisible
    @StateObject private var viewModel = PromptLibraryViewModel()
    @State private var selectedPrompt: Prompt?
    @State private var presentationState: PresentationState?
    
    var body: some View {
        ZStack {
            // Base background - dark gradient
            LinearGradient(
                colors: [
                    Color.black.opacity(0.8),
                    Color.black.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Glass effect background
            VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                .ignoresSafeArea()
            
            // Main content
            VStack(spacing: 0) {
                NavigationView {
                    if isSidebarVisible {
                        // Left sidebar
                        PromptListView(
                            searchText: $viewModel.searchText,
                            prompts: viewModel.filteredPrompts,
                            selectedPrompt: $selectedPrompt
                        )
                        .frame(minWidth: 250, maxWidth: 350, minHeight: 400)
                        .frame(width: 300)
                        .background(.ultraThinMaterial)
                    }
                    
                    // Right content area
                    ZStack {
                        if let prompt = selectedPrompt {
                            PromptDetailView(prompt: prompt)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Text("Select a prompt")
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(minWidth: 400)
                    .background(.ultraThinMaterial)
                }
                
                BottomBar(presentationState: $presentationState)
            }
        }
        .preferredColorScheme(.dark)
        .searchable(text: $viewModel.searchText, prompt: "Search prompts...")
        .sheet(item: $presentationState) { state in
            switch state {
            case .commandMenu:
                CommandMenuView(
                    presentationState: $presentationState,
                    selectedPrompt: $selectedPrompt,
                    viewModel: viewModel
                )
            case .newPrompt:
                PromptFormView(
                    presentationState: $presentationState,
                    viewModel: viewModel
                )
            }
        }
    }
}

// NSVisualEffectView wrapper for better glass effect
struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = .active
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
 

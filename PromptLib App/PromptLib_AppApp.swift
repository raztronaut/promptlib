import SwiftUI

@main
struct PromptLibApp: App {
    @AppStorage("isSidebarVisible") private var isSidebarVisible: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .frame(minWidth: 800, minHeight: 600)
                .environment(\.isSidebarVisible, isSidebarVisible)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .defaultSize(width: 1200, height: 800)
        .commands {
            CommandGroup(after: .sidebar) {
                Toggle("Show Sidebar", isOn: $isSidebarVisible)
                    .keyboardShortcut("[", modifiers: .command)
            }
            
            CommandGroup(after: .appInfo) {
                Button("Settings...") {
                    openSettings()
                }
                .keyboardShortcut(",", modifiers: .command)
                
                Button("Help") {
                    openHelp()
                }
                .keyboardShortcut("?", modifiers: .command)
            }
        }
        
        Settings {
            SettingsView()
        }
    }
    
    private func openSettings() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
    
    private func openHelp() {
        NSApp.sendAction(Selector(("showHelpWindow:")), to: nil, from: nil)
    }
}

private struct SidebarVisibilityKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

extension EnvironmentValues {
    var isSidebarVisible: Bool {
        get { self[SidebarVisibilityKey.self] }
        set { self[SidebarVisibilityKey.self] = newValue }
    }
}

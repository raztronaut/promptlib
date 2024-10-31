import SwiftUI

struct BottomBar: View {
    @Binding var presentationState: PresentationState?
    @State private var isHovered = false
    
    var body: some View {
        HStack {
            // App name and icon on the left
            HStack(spacing: 8) {
                Image(systemName: "square.text.square.fill")
                    .foregroundColor(.secondary)
                Text("PromptLib")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 12)
            
            Spacer()
            
            // Command menu button on the right
            Button(action: {
                presentationState = .commandMenu
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "command.square.fill")
                        .font(.system(size: 12))
                    Text("Commands")
                        .font(.system(size: 12))
                    Text("⌘K")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isHovered ? Color.gray.opacity(0.3) : Color.clear)
                )
            }
            .buttonStyle(.plain)
            .onHover { hovering in
                isHovered = hovering
            }
            .padding(.horizontal, 12)
        }
        .frame(height: 32)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .top)
    }
}

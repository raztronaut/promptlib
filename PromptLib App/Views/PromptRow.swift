import SwiftUI

struct PromptRow: View {
    let prompt: Prompt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(prompt.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(prompt.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .contentShape(Rectangle())
    }
}

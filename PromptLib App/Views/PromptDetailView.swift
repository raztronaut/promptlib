import SwiftUI

struct PromptDetailView: View {
    let prompt: Prompt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Content section
            ContentSection(content: prompt.content)
            
            // Info section
            InfoSection(prompt: prompt)
            
            // Tags section
            TagsSection(tags: Array(prompt.tags))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// Content Section
private struct ContentSection: View {
    let content: String
    
    var body: some View {
        Text(content)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black.opacity(0.2))
            .cornerRadius(12)
    }
}

// Info Section
private struct InfoSection: View {
    let prompt: Prompt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Information")
                .font(.headline)
            
            InfoRow(
                icon: "calendar",
                title: "Created",
                value: prompt.createdAt.formatted(date: .abbreviated, time: .shortened)
            )
            
            InfoRow(
                icon: "cpu",
                title: "Model",
                value: prompt.model
            )
        }
    }
}

// Tags Section
private struct TagsSection: View {
    let tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tags")
                .font(.headline)
            
            FlowLayout(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            }
        }
    }
}

// Helper Views
private struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}

private struct TagView: View {
    let tag: String
    
    var body: some View {
        Text(tag)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(8)
    }
}

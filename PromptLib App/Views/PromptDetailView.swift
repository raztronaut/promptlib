import SwiftUI

struct PromptDetailView: View {
    let prompt: Prompt
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Content
                Text(prompt.content)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
                
                // Info section
                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(icon: "calendar", title: "Created", value: prompt.createdAt.formatted(date: .abbreviated, time: .shortened))
                    InfoRow(icon: "cpu", title: "Model", value: prompt.model)
                    
                    // Tags
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Tags", systemImage: "tag")
                        FlowLayout(spacing: 8) {
                            ForEach(prompt.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(12)
            }
            .padding()
        }
        .background(Color.clear)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

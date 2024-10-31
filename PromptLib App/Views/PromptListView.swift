import SwiftUI

struct PromptListView: View {
    @Binding var searchText: String
    let prompts: [Prompt]
    @Binding var selectedPrompt: Prompt?
    
    // Compute organized sections
    private var organizedSections: [(String, [Prompt])] {
        // Get all unique tags
        let allTags = Set(prompts.flatMap { $0.tags })
        
        // Create dictionary to store prompts by tag
        var promptsByTag: [String: [Prompt]] = [:]
        
        // Initialize untagged section
        var untaggedPrompts: [Prompt] = []
        
        // Organize prompts by tags
        for prompt in prompts {
            if prompt.tags.isEmpty {
                untaggedPrompts.append(prompt)
            } else {
                for tag in prompt.tags {
                    promptsByTag[tag, default: []].append(prompt)
                }
            }
        }
        
        // Sort sections alphabetically
        var sections = promptsByTag.map { ($0.key, $0.value) }
            .sorted { $0.0 < $1.0 }
        
        // Add untagged section at the end if not empty
        if !untaggedPrompts.isEmpty {
            sections.append(("Untagged", untaggedPrompts))
        }
        
        return sections
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(organizedSections, id: \.0) { section in
                    SectionHeader(title: section.0)
                    
                    ForEach(section.1) { prompt in
                        PromptRow(prompt: prompt)
                            .background(
                                selectedPrompt?.id == prompt.id ?
                                    Color.accentColor.opacity(0.2) :
                                    Color.clear
                            )
                            .onTapGesture {
                                selectedPrompt = prompt
                            }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

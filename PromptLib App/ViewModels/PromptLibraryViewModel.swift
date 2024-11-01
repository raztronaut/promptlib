import Foundation

class PromptLibraryViewModel: ObservableObject {
    @Published var prompts: [Prompt] = []
    @Published var searchText = ""
    
    private var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("prompts.json")
    }
    
    var filteredPrompts: [Prompt] {
        if searchText.isEmpty {
            return prompts
        }
        return prompts.filter { prompt in
            prompt.title.localizedCaseInsensitiveContains(searchText) ||
            prompt.content.localizedCaseInsensitiveContains(searchText) ||
            prompt.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        print("ViewModel initialized")
        loadPrompts()
        
        // If no prompts were loaded, add sample prompts
        if prompts.isEmpty {
            prompts = [
                Prompt(
                    title: "Test Prompt",
                    content: "This is a test prompt content that demonstrates how prompts look in the app. It can be quite long and will show how the text wraps.",
                    model: "GPT-4",
                    tags: Set(["test", "sample"])
                ),
                Prompt(
                    title: "Writer Prompt",
                    content: "This is a writer prompt content that helps with writing tasks. It includes specific instructions and examples.",
                    model: "Claude",
                    tags: Set(["writing", "email"])
                )
            ]
            savePrompts()
            print("Added \(prompts.count) sample prompts")
        }
    }
    
    func addPrompt(_ prompt: Prompt) {
        prompts.append(prompt)
        savePrompts()
        print("Added new prompt: \(prompt.title)")
    }
    
    func deletePrompt(_ prompt: Prompt) {
        prompts.removeAll { $0.id == prompt.id }
        savePrompts()
        print("Deleted prompt: \(prompt.title)")
    }
    
    func updatePrompt(_ prompt: Prompt) {
        if let index = prompts.firstIndex(where: { $0.id == prompt.id }) {
            prompts[index] = prompt
            savePrompts()
            print("Updated prompt: \(prompt.title)")
        }
    }
    
    private func loadPrompts() {
        do {
            let data = try Data(contentsOf: fileURL)
            let loadedPrompts = try JSONDecoder().decode([Prompt].self, from: data)
            if !loadedPrompts.isEmpty {
                prompts = loadedPrompts
                print("Loaded \(prompts.count) prompts from file")
            }
        } catch {
            print("Error loading prompts: \(error)")
        }
    }
    
    func savePrompts() {
        do {
            let data = try JSONEncoder().encode(prompts)
            try data.write(to: fileURL)
            print("Saved \(prompts.count) prompts to file")
        } catch {
            print("Error saving prompts: \(error)")
        }
    }
    
    func toggleFavorite(_ prompt: Prompt) {
        if let index = prompts.firstIndex(where: { $0.id == prompt.id }) {
            var updatedPrompt = prompt
            if updatedPrompt.tags.contains("Favorites") {
                updatedPrompt.tags.remove("Favorites")
            } else {
                updatedPrompt.tags.insert("Favorites")
            }
            prompts[index] = updatedPrompt
            savePrompts()
        }
    }
}

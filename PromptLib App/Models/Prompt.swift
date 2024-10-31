import Foundation

struct Prompt: Codable, Identifiable, Hashable {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var model: String
    var tags: [String]
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        model: String,
        tags: [String] = [],
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.model = model
        self.tags = tags
        self.isFavorite = isFavorite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Prompt, rhs: Prompt) -> Bool {
        lhs.id == rhs.id
    }
} 

import Foundation

struct Prompt: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var model: String
    var tags: Set<String>
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, content: String, model: String, tags: Set<String>, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.model = model
        self.tags = tags
        self.createdAt = createdAt
    }
}

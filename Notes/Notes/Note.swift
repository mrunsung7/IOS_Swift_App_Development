import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var text: String
    var timestamp: Date
    
    init(id: UUID = UUID(), text: String, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.timestamp = timestamp
    }
} 
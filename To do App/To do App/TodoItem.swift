import Foundation

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    
    static func loadTodos() -> [TodoItem] {
        if let data = UserDefaults.standard.data(forKey: "todos"),
           let todos = try? JSONDecoder().decode([TodoItem].self, from: data) {
            return todos
        }
        return []
    }
    
    static func saveTodos(_ todos: [TodoItem]) {
        if let data = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(data, forKey: "todos")
        }
    }
} 
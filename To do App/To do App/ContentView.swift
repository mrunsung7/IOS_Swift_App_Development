//
//  ContentView.swift
//  To do App
//
//  Created by Ashwin Kumar on 15/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var todos = TodoItem.loadTodos()
    @State private var newTodoTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Add new todo section
                HStack {
                    TextField("New todo", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.blue)
                            .font(.title2)
                    }
                }
                .padding()
                
                // Todo list
                List {
                    ForEach($todos) { $todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    todo.isCompleted.toggle()
                                    TodoItem.saveTodos(todos)
                                }
                            
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                        }
                    }
                    .onDelete(perform: deleteTodos)
                }
            }
            .navigationTitle("Todo List")
        }
    }
    
    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        
        let todo = TodoItem(title: newTodoTitle, isCompleted: false)
        todos.append(todo)
        TodoItem.saveTodos(todos)
        newTodoTitle = ""
    }
    
    private func deleteTodos(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        TodoItem.saveTodos(todos)
    }
}

#Preview {
    ContentView()
}

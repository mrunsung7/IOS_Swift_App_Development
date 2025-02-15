//
//  ContentView.swift
//  Notes
//
//  Created by Ashwin Kumar on 14/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var newNoteText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Text input for new notes
                TextField("Write your note here...", text: $newNoteText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button(action: addNote) {
                    Text("Save Note")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(newNoteText.isEmpty)
                
                // List of existing notes
                List {
                    ForEach(notes.sorted(by: { $0.timestamp > $1.timestamp })) { note in
                        VStack(alignment: .leading) {
                            Text(note.text)
                                .padding(.vertical, 4)
                            Text(note.timestamp.formatted())
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
            }
            .navigationTitle("My Notes")
            .onAppear(perform: loadNotes)
        }
    }
    
    private func addNote() {
        let note = Note(text: newNoteText)
        notes.append(note)
        saveNotes()
        newNoteText = ""
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    private func loadNotes() {
        if let savedNotes = UserDefaults.standard.data(forKey: "notes"),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: savedNotes) {
            notes = decodedNotes
        }
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct PromptFormView: View {
    @Binding var presentationState: PresentationState?
    @ObservedObject var viewModel: PromptLibraryViewModel
    var editingPrompt: Prompt?
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var model: String = ""
    @State private var tags: Set<String> = []
    @State private var tagInput: String = ""
    
    init(presentationState: Binding<PresentationState?>, viewModel: PromptLibraryViewModel, editingPrompt: Prompt? = nil) {
        self._presentationState = presentationState
        self.viewModel = viewModel
        self.editingPrompt = editingPrompt
        
        // Initialize state with editing prompt values if available
        if let prompt = editingPrompt {
            _title = State(initialValue: prompt.title)
            _content = State(initialValue: prompt.content)
            _model = State(initialValue: prompt.model)
            _tags = State(initialValue: Set(prompt.tags))
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            
            TextEditor(text: $content)
                .frame(height: 200)
                .border(Color.secondary.opacity(0.2))
            
            TextField("Model (e.g., GPT-4, Claude)", text: $model)
                .textFieldStyle(.roundedBorder)
            
            VStack(alignment: .leading) {
                HStack {
                    TextField("Add tags...", text: $tagInput)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        if !tagInput.isEmpty {
                            tags.insert(tagInput)
                            tagInput = ""
                        }
                    }
                }
                
                FlowLayout(spacing: 8) {
                    ForEach(Array(tags), id: \.self) { tag in
                        HStack {
                            Text(tag)
                            Button {
                                tags.remove(tag)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
            
            HStack {
                Button("Cancel") {
                    presentationState = nil
                }
                
                Spacer()
                
                Button("Save") {
                    savePrompt()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(width: 500)
    }
    
    private func savePrompt() {
        let prompt = Prompt(
            id: editingPrompt?.id ?? UUID(),
            title: title,
            content: content,
            model: model,
            tags: tags,
            createdAt: editingPrompt?.createdAt ?? Date()
        )
        
        if editingPrompt != nil {
            viewModel.updatePrompt(prompt)
        } else {
            viewModel.addPrompt(prompt)
        }
        presentationState = nil
    }
}

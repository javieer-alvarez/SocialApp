//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 15/8/25.
//

import SwiftUI

struct NewPostForm: View {
    
    @StateObject var viewModel: FormViewModel<Post>
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                }
                Section("Content") {
                    TextEditor(text: $viewModel.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: viewModel.submit) {
                    if viewModel.isWorking {
                        ProgressView()
                    } else {
                        Text("Create Post")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(viewModel.submit)
            .navigationTitle("New Post")
        }
        .disabled(viewModel.isWorking)
        .alert("Cannot Create Post", error: $viewModel.error)
        .onChange(of: viewModel.isWorking){
            if !viewModel.isWorking && viewModel.error == nil {
                dismiss()
            }
        }
    }
}

#Preview {
    NewPostForm(viewModel: FormViewModel(initialValue: Post.testPost, action: { _ in }))
}

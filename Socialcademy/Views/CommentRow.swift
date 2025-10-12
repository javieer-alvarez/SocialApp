//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 10/10/25.
//

import SwiftUI

struct CommentRow: View{
    
    @ObservedObject var viewModel: CommentRowViewModel
    
    @State private var showConfirmationDialog = false
        
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .top){
                Text(viewModel.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(viewModel.date.formatted())
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(viewModel.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
        .swipeActions {
            if viewModel.canDeleteComment {
                Button(role: .destructive) {
                    showConfirmationDialog = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .confirmationDialog("Are you sure you want to delet this comment?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: {
                viewModel.deleteComment()
            })
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CommentRow(viewModel: CommentRowViewModel(comment: Comment.testComment, deleteAction: {}))
}

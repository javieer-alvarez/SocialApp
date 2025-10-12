//
//  CommentsListView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 10/10/25.
//

import SwiftUI

struct CommentsList: View {
    
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        Group{
            switch viewModel.comments {
            case .loading:
                ProgressView()
                    .onAppear{
                        viewModel.fetchComments()
                    }
            case let .error(error):
                EmptyListView(
                    title: "Couldn't load comments",
                    message: error.localizedDescription,
                    retryAction: {
                        viewModel.fetchComments()
                    }
                    )
            case .empty:
                EmptyListView(title: "No comments", message: "Be the first one to comment!")
                    .toolbar{
                        ToolbarItem(placement: .bottomBar) {
                            NewCommentForm(viewModel: viewModel.makeNewCommentViewModel())
                        }
                    }
            case let .loaded(comments):
                List(comments){ comment in
                    CommentRow(viewModel: viewModel.makeCommentRowViewModel(for: comment))
                }
                .toolbar{
                    ToolbarItem(placement: .bottomBar) {
                        NewCommentForm(viewModel: viewModel.makeNewCommentViewModel())
                    }
                }
                .animation(.default, value: comments)
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension CommentsList {
    struct NewCommentForm: View {
        @StateObject var viewModel: FormViewModel<Comment>
        
        var body: some View {
            HStack{
                TextField("Comment", text: $viewModel.content)
                Button(action: viewModel.submit) {
                    if viewModel.isWorking {
                        ProgressView()
                    }
                    else {
                        Image(systemName: "paperplane")
                    }
                }
            }
            .alert("Cannot Post Comment", error: $viewModel.error)
            .animation(.default, value: viewModel.isWorking)
            .disabled(viewModel.isWorking)
            .onSubmit(viewModel.submit)
            .padding(.horizontal, 9)
        }
    }
}

@MainActor
private func commentsList(state: Loadable<[Comment]>) -> some View {
    NavigationStack {
        CommentsList(
            viewModel: CommentsViewModel(
                commentsRepository: CommentsRepositoryStub(state: state)
            )
        )
    }
}

#if DEBUG
#Preview("Loaded", traits: .defaultLayout) {
    commentsList(state: .loaded([Comment.testComment]))
}

#Preview("Loading", traits: .defaultLayout) {
    commentsList(state: .loading)
}

#Preview("Empty", traits: .defaultLayout) {
    commentsList(state: .empty)
}

#Preview("Error", traits: .defaultLayout) {
    commentsList(state: .error)
}
#endif

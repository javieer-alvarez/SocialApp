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
            case let .loaded(comments):
                List(comments){ comment in
                    CommentRow(comment: comment)
                }
                .animation(.default, value: comments)
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview("Loaded", traits: .defaultLayout) {
    commentsList(state: .empty)
}

#Preview("Error", traits: .defaultLayout) {
    commentsList(state: .error)
}
#endif

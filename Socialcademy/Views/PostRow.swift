//
//  PostRow.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 1/9/25.
//

import SwiftUI

struct PostRow: View {
    
    @ObservedObject var viewModel : PostRowViewModel
    
    @EnvironmentObject private var factory: ViewModelFactory

    @State private var showConfirmationDialog = false
    @State private var showCommentSection = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            //MARK: - INFO
            HStack {
                AuthorView(author: viewModel.author, currentFilter: viewModel.currentFilter)
                Spacer()
                Text(viewModel.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundColor(.gray)
            if let imageURL = viewModel.imageURL {
                PostImage(url: imageURL)
            }
            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(viewModel.content)
            
            //MARK: - ACTIONS
            HStack{
                FavoriteButton(isFavorite: viewModel.isFavorite, action: viewModel.favoritePost)
                Button{
                    showCommentSection = true
                } label: {
                    Label("Comments", systemImage: "text.bubble")
                        .foregroundColor(.secondary)
                }
                .sheet(isPresented: $showCommentSection){
                    NavigationStack {
                        CommentsList(viewModel: factory.makeCommentsViewModel(for: viewModel.post))
                    }
                }
                Spacer()
                if viewModel.canDeletePost{
                    Button(role: .destructive, action: {
                        showConfirmationDialog = true
                    }){
                        Label("Delete", systemImage: "trash")
                    }
                }

            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
        }
        .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible){
            Button("Delete", role: .destructive, action: viewModel.deletePost)
        }
        .alert("Error", error: $viewModel.error)
        .padding()
    }
    
}

private extension PostRow {
    struct FavoriteButton: View{
        
        let isFavorite: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action){
                if isFavorite{
                    Label("Remove from Favorites", systemImage: "heart.fill")
                }
                else{
                    Label("Add to Favorites", systemImage: "heart")
                }
            }
            .foregroundColor(isFavorite ? .red : .gray)
            .animation( .default, value: isFavorite)
        }
    }
}

private extension PostRow {
    
    struct AuthorView: View {
        let author: User
        let currentFilter: PostsViewModel.Filter
        
        @EnvironmentObject private var factory: ViewModelFactory
        
        var body: some View {
            
            switch currentFilter {
            case .all, .favorites:
                NavigationLink{
                    PostsList(viewModel: factory.makePostsViewModel(filter: .author(author)))
                } label: {
                    HStack {
                        ProfileImage(url: author.imageURL)
                            .frame(width: 40, height: 40)
                        Text(author.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
            case .author:
                EmptyView()
            }
        }
    }
}

private extension PostRow {
    struct PostImage: View {
        let url: URL
        
        var body: some View {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.clear
            }
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PostRow(viewModel: PostRowViewModel(post: Post.testPost, deleteAction: {}, favoriteAction: {}, currentFilter: .all))
        .environmentObject(ViewModelFactory(user: User.testUser, authService: AuthService()))
}

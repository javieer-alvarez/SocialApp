//
//  PostsList.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 1/9/25.
//

import SwiftUI


struct PostsList: View {
    @StateObject var viewModel: PostsViewModel
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
        
    var body: some View {
        
            Group {
                switch viewModel.posts {
                case .loading:
                    ProgressView()
                case let .error(error):
                    EmptyListView(title: "Cannot Load Posts", message: "\(error)", retryAction: {viewModel.fetchPosts()})
                case .empty:
                    EmptyListView(title: "No posts yet", message: "Be the first to create one!")
                case let .loaded(posts):
                    ScrollView {
                        ForEach(posts) { post in
                            if searchText.isEmpty || post.contains(searchText) {
                                PostRow(viewModel: viewModel.makePostRowViewModel(for: post))
                            }
                        }
                        .animation(.default, value: posts)
                    }
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(viewModel: viewModel.makeNewPostViewModel())
            }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

#if DEBUG
struct PostsList_Previews: PreviewProvider {
    
    @MainActor
    private struct ListPreview: View{
        let state: Loadable<[Post]>
        
        var body: some View{
            
            let postsRepository = PostsRepositoryStub(state: state)
            let viewModel = PostsViewModel(postsRepository: postsRepository)
            NavigationStack {
                PostsList(viewModel: viewModel)
            }
        }
    }
    
    static var previews: some View {
        ListPreview(state: .loaded([Post.testPost]))
        ListPreview(state: .empty)
        ListPreview(state: .error)
        ListPreview(state: .loading)
    }
}
#endif


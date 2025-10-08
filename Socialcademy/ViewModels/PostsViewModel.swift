//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 1/9/25.
//

import SwiftUI

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: Loadable<[Post]> = .loading
    
    private let postsRepository: PostsRepositoryProtocol
    private let filter: Filter
    
    var title: String {
        switch filter {
        case .all:
            return "Posts"
        case let .author(author):
            return "\(author.name)'s Posts"
        case .favorites:
            return "Favorites"
        }
    }
    
    init(filter: Filter = .all, postsRepository: PostsRepositoryProtocol){
        self.filter = filter
        self.postsRepository = postsRepository
    }
    
    func makePostRowViewModel(for post: Post) -> PostRowViewModel {
        
        let deleteAction = {
            [weak self] in
                try await self?.postsRepository.delete(post)
                self?.posts.value?.removeAll { $0.id == post.id}
        }
        
        let favoriteAction = {
            [weak self] in
                let newValue = !post.isFavorite
                try await newValue ? self?.postsRepository.favorite(post) : self?.postsRepository.unfavorite(post)
                guard let i = self?.posts.value?.firstIndex(of: post) else {return}
                self?.posts.value?[i].isFavorite = newValue
        }
        
        return PostRowViewModel(
            post: post,
            deleteAction: postsRepository.canDelete(post) ? deleteAction : nil,
            favoriteAction: favoriteAction
        )
    }
    
    func makeNewPostViewModel() -> FormViewModel<Post> {
        return FormViewModel(initialValue: Post(title: "", content: "", author: postsRepository.user), action: {
            [weak self] post in
            try await self?.postsRepository.create(post)
            self?.posts.value?.insert(post, at: 0)
        })
    }
    
    func fetchPosts() {
        Task {
            do {
                posts = .loaded(try await postsRepository.fetchPosts(for: filter))
            } catch {
                print("[PostsViewModel] Cannot fetch posts: \(error)")
                posts = .error(error)
            }
        }
    }
    
    enum Filter{
        case all, author(User), favorites
    }
}

private extension PostsRepositoryProtocol{
    func fetchPosts(for filter: PostsViewModel.Filter) async throws -> [Post]{
        switch filter{
        case .all:
            return try await fetchAllPosts()
        case let .author(author):
            return try await fetchPosts(from: author)
        case .favorites:
            return try await fetchFavoritePosts()
        }
    }
}

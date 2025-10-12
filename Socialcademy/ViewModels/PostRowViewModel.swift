//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 23/9/25.
//
import SwiftUI

@MainActor
@dynamicMemberLookup
class PostRowViewModel: ObservableObject, ErrorHandler{
    
    typealias Action = () async throws -> Void
    
    @Published var post: Post
    @Published var error: Error?
    
    subscript <T>(dynamicMember keyPath: KeyPath<Post, T>) -> T {
        post[keyPath: keyPath]
    }
    
    private let deleteAction: Action?
    private let favoriteAction: Action
    
    var canDeletePost: Bool { deleteAction != nil}
    
    let currentFilter: PostsViewModel.Filter
    
    init(post: Post, deleteAction: Action?, favoriteAction: @escaping Action, currentFilter: PostsViewModel.Filter){
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
        self.currentFilter = currentFilter
    }
    
    func deletePost(){
        guard let deleteAction = deleteAction else {
        
            preconditionFailure("Cannot delete post, no delete action provided")
        }
        withErrorHandlingTask(perform: deleteAction)
    }
    func favoritePost(){
        withErrorHandlingTask(perform: favoriteAction)
    }
    
}

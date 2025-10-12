//
//  CommentRowViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 11/10/25.
//

import SwiftUI

@MainActor
@dynamicMemberLookup
class CommentRowViewModel: ObservableObject {
    
    typealias Action = () async throws -> Void
    
    @Published var comment: Comment
    @Published var error: Error?
    
    private let deleteAction: Action?
    
    var canDeleteComment: Bool { deleteAction != nil }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Comment, T>) -> T {
            comment[keyPath: keyPath]
        }
    
    init(comment: Comment, deleteAction: Action?) {
        self.comment = comment
        self.deleteAction = deleteAction
    }
    
    func deleteComment() {
        guard let deleteAction = deleteAction else { preconditionFailure("Cannot delete comment: no delete action provided")}
        Task{
            do {
                try await deleteAction()
            } catch {
                print("[CommentRowViewModel] Cannot delete comment: \(error)")
                self.error = error
            }
        }
    }
}

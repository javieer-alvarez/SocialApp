//
//  CommentsViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 10/10/25.
//

import SwiftUI

@MainActor
class CommentsViewModel: ObservableObject {
    
    @Published var comments: Loadable<[Comment]> = .loading
    
    private let commentsRepository: CommentsRepositoryProtocol
    
    init(commentsRepository: CommentsRepositoryProtocol){
        self.commentsRepository = commentsRepository
    }
    
    func fetchComments(){
        Task{
            do{
                comments = .loaded(try await commentsRepository.fetchComments())
            }
            catch {
                print("[CommentsViewModel] Error loading comments \(error)")
                comments = .error(error)
            }
        }
        
    }
}

//
//  ViewModelFactory.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 5/10/25.
//

import SwiftUI

@MainActor
class ViewModelFactory: Observable, ObservableObject{
    
    private let user: User
    
    init(user: User){
        self.user = user
    }
    
    func makePostsViewModel(filter: PostsViewModel.Filter = .all) -> PostsViewModel {
        
        return PostsViewModel(filter: filter, postsRepository: PostsRepository(user: user))
        
    }
    
}

#if DEBUG

extension ViewModelFactory {
    static let preview = ViewModelFactory(user: User.testUser)
}
#endif

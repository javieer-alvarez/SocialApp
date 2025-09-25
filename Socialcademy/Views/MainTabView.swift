//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 24/9/25.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView{
            Tab("Posts", systemImage: "list.dash"){
                PostsList()
            }
            Tab("Favorites", systemImage: "heart"){
                PostsList(viewModel: PostsViewModel(filter: .favorites))
            }
        }
    }
}

#Preview {
    MainTabView()
}

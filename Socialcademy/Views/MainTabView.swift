//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 24/9/25.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var factory: ViewModelFactory
    
    var body: some View {
        TabView{
            Tab("Posts", systemImage: "list.dash"){
                NavigationStack {
                    PostsList(viewModel: factory.makePostsViewModel())
                }
            }
            Tab("Favorites", systemImage: "heart"){
                NavigationStack {
                    PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
                }
            }
            Tab("Profile", systemImage: "person"){
                ProfileView()
            }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModelFactory.preview)
}

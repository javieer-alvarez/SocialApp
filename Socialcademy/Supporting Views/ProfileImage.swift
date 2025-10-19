//
//  ProfileImage.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 19/10/25.
//

import SwiftUI

struct ProfileImage: View {
    
    let url: URL?
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.clear
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.25)))
        }
    }
}

#Preview {
    ProfileImage(url: URL(string: "https://images.unsplash.com/photo-1531259683007-016a7b628fc3?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2000"))
}

//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 26/9/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AsyncImage(url: viewModel.imageURL)
                    .frame(width: 200, height: 200)
                Spacer()
                Text(viewModel.name)
                    .font(.title2)
                    .bold()
                    .padding()
                ImagePickerButton(imageURL: $viewModel.imageURL) {
                    Label("Choose Image", systemImage: "photo.fill")
                }
                Spacer()
            }
            .navigationTitle("Profile")
            .toolbar {
                Button("Sign Out") {
                    viewModel.signOut()
                }
            }
        }
        .alert("Error", error: $viewModel.error)
        .disabled(viewModel.isWorking)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(user: User.testUser, authService: AuthService()))
}

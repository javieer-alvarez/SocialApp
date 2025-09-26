//
//  AuthView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 26/9/25.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView()
        } else{
            Form{
                TextField("Email", text: $viewModel.email)
                TextField("Password", text: $viewModel.password)
                Button("Sign In"){
                    viewModel.signIn()
                }
            }
        }
    }
}

#Preview {
    AuthView()
}

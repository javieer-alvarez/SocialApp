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
        if viewModel.user != nil {
            MainTabView()
        } else{
            NavigationStack{
                SignInForm(viewModel: viewModel.makeSignInViewModel()){
                    NavigationLink("Create Account"){
                        CreateAccountView(viewModel: viewModel.makeCreateAccountViewModel())
                    }
                }
            }
        }
    }
}

private extension AuthView {
    
    struct CreateAccountView: View {
        
        @StateObject var viewModel: AuthViewModel.CreateAccountViewModel
        @Environment(\.dismiss) private var dismiss
        
        var body: some View {
            Form{
                TextField("Name", text: $viewModel.name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
            } footer: {
                Button("Create Account", action: {viewModel.submit()})
                    .buttonStyle(.primary)
                Button("Sign In", action: dismiss.callAsFunction)
                    .padding()
            }
            .onSubmit({viewModel.submit()})
            .alert("Cannot Create Account", error: $viewModel.error)
            .disabled(viewModel.isWorking)
        }
    }
    
    struct SignInForm<Footer: View>: View {
        
        @StateObject var viewModel: AuthViewModel.SignInViewModel
        @ViewBuilder let footer: () -> Footer
        
        
        var body: some View{
            Form{
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
            } footer: {
                Button("Sign In", action: {viewModel.submit()})
                    .buttonStyle(.primary)
                footer()
                    .padding()
            }
            .onSubmit({viewModel.submit()})
            .alert("Cannot Sign In", error: $viewModel.error)
            .disabled(viewModel.isWorking)
        }
    }

    
    struct Form<Content: View, Footer: View>: View {
        
        @ViewBuilder let content: () -> Content
        @ViewBuilder let footer: () -> Footer
        
        var body: some View{
            VStack{
                Text("Social")
                    .font(.title.bold())
                content()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.secondary.opacity(0.15))
                    .cornerRadius(10)
                footer()
            }
            .navigationBarHidden(true)
            .padding()
        }
        
    }
    
}

#Preview {
    AuthView()
}

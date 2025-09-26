//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 26/9/25.
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject{
    @Published var isAuthenticated = false
    
    @Published var email = ""
    @Published var password = ""
    
    private let authService = AuthService()
    
    init(){
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn() {
        Task{
            do{
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("[AuthViewModel], Error trying to sign in \(error)")
            }
        }
    }
}

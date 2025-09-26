//
//  AuthService.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 25/9/25.
//
import SwiftUI
import FirebaseAuth

@MainActor
class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    
    private let Auth.auth()
    private var listener = AuthStateDidChangeListenerHandle?
    
    init(){
        listener = auth.addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
        }
    }
    
    func createAccount(name: String, email: String, password: String) async throws {
        let result = try await auth.createUser(withEmail: email, password: password)
        try await result.user.updateProfile(\.displayName, to: name)
    }
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signOut() async throws {
        try await auth.signOut()
    }
    
}

private extension FirebaseAuth.User{
    func updateProfile<T>(_ keyPath: WritableKeyPath<UserProfileChangeRequest, T>, to newValue: T) async throws {
        var profileChangeRequest = createProfileChangeRequest()
        profileChangeRequest[keyPath: keyPath] = newValue
        try await profileChangeRequest.commitChanges()
    }
}

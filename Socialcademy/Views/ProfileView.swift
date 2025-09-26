//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 26/9/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {

    var body: some View {
        Button("Sign Out"){
            try! Auth.auth().signOut()
        }
    }
}

#Preview {
    ProfileView()
}

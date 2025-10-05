//
//  User.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 5/10/25.
//

import SwiftUI

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
}

extension User{
    static let testUser = User(id: "", name: "Jamie Harris")
}

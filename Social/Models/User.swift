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
    var imageURL: URL?
}

extension User{
    static let testUser = User(id: "", name: "Jamie Harris", imageURL: URL(string: "https://randomuser.me/api/portraits/men/44.jpg"))
}

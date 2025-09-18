//
//  PostRow.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 1/9/25.
//

import SwiftUI

struct PostRow: View {
    
    typealias DeleteAction = () async throws -> Void

    let post: Post
    let delete: DeleteAction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.author)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(post.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundColor(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
        }
        .padding(.vertical)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(post: Post.testPost, delete: {})
        }
    }
}

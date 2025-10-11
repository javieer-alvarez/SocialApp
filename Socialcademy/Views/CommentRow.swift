//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 10/10/25.
//

import SwiftUI

struct CommentRow: View{
    
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .top){
                Text(comment.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(comment.date.formatted())
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(comment.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CommentRow(comment: Comment.testComment)
}

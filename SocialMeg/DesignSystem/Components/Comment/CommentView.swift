//
//  CommentView.swift
//  SocialMeg
//
//  Created by Raul Menezes on 08/11/2022.
//

import SwiftUI

struct CommentView: View {
    let userId: Int
    let name: String
    let email: String
    let comment: String
    
    var body: some View {
        HStack(
            alignment: .bottom,
            spacing: .Spacing.xs
        ) {
            AvatarView(userId: userId)
                .padding(.top, .Spacing.xs)
                .accessibilityIdentifier(.AccessibilityIdentifier.Comment.avatar)
                .accessibilityElement(children: .contain)
            
            VStack(
                alignment: .leading,
                spacing: .Spacing.xxs
            ) {
                Text(name)
                    .font(.caption)
                    .foregroundColor(.Text.primary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Comment.name)
                    .accessibilityElement(children: .contain)
                Text(email)
                    .font(.caption2)
                    .foregroundColor(.Text.primary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Comment.email)
                    .accessibilityElement(children: .contain)
                Text(comment)
                    .font(.body)
                    .foregroundColor(.Text.secondary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Comment.comment)
                    .accessibilityElement(children: .contain)
            }
            .padding(.trailing, .Spacing.md)
            
            Spacer()
        }
        .padding(.vertical, .Spacing.xs)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(
            userId: 1,
            name: "Raul Menezes",
            email: "raul@rmenezes.me",
            comment: "Nice post"
        )
    }
}

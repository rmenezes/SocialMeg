import SwiftUI

struct LikeButton: View {
    let onLike: () -> Void
    let isLiked: Bool
    let numberOfLikes: Int
    
    var body: some View {
        VStack {
            Button(action: {
                onLike()
            }, label: {
                Image(
                    systemName: isLiked ? Constants.liked : Constants.notLiked
                )
            })
            
            Text("\(numberOfLikes)")
        }
    }
}

extension LikeButton {
    struct Constants {
        static let liked = "hand.thumbsup.fill"
        static let notLiked = "hand.thumbsup"
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LikeButton(
                onLike: {},
                isLiked: true,
                numberOfLikes: 0
            )
            
            LikeButton(
                onLike: {},
                isLiked: false,
                numberOfLikes: 0
            )
        }
    }
}

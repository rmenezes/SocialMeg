import SwiftUI

struct AvatarView: View {
    let userId: Int
    
    var body: some View {
        Circle()
            .fill(Color.System.separator)
            .frame(
                width: .Image.avatar,
                height: .Image.avatar
            )
            .overlay(
                Image("avatar_\(userId)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: .Image.avatar,
                        height: .Image.avatar
                    )
            )
            .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(userId: 1)
    }
}

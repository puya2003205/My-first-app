import SwiftUI

struct CommentCard: View {
    @State var activityInStore: Comment
    
    var body: some View {
        HStack {
            Text(activityInStore.date)
            Spacer()
            Text(activityInStore.activity.title)
            Spacer()
            Text(activityInStore.activity.role?.rawValue ?? "")
            Spacer()
            Text(activityInStore.comment)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
}

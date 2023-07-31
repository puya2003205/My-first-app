import SwiftUI

struct CommentCard: View {
    @State var activity: Activity
    @State var comment: Comment
    
    var body: some View {
        HStack {
            Text(comment.date)
            Spacer()
            Text(activity.title)
            Spacer()
            Text(activity.role?.rawValue ?? "")
            Spacer()
            Text(comment.comment)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
        
    }
    
}

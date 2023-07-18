import SwiftUI

struct CommentCard: View {
    @State var activity: Activity
    
    var body: some View {
        HStack {
//            Text(activity.comments)
//            Spacer()
            Text(activity.title)
            Spacer()
            Text(activity.role?.rawValue ?? "")
            Spacer()
//            Text(activity.comment)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 5)
//                .background(Color.gray)
//                .cornerRadius(10)
//                .foregroundColor(.white)
        }
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
}

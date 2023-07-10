import SwiftUI

struct AllComments: View {
    @ObservedObject var commentsStore: ActivityDetailStore
    
    
    var body: some View {
        VStack(alignment: .trailing) {
            List {
                ForEach(commentsStore.allComments.reversed(), id: \.id) { commentInAllComments in
                    NavigationLink(destination: ActivityDetailsView(activity: commentInAllComments.activity, commentsStore: commentsStore)) {
                        CommentCard(activityInStore: commentInAllComments)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}

struct CommentCard: View {
    @State var activityInStore: CommentStruct
    
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

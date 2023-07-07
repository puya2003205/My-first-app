import SwiftUI

struct AllComments: View {
    @ObservedObject var commentsStore: ActivityDetailStore
    
    
    var body: some View {
        VStack(alignment: .trailing) {
            List {
                ForEach(commentsStore.allComments.reversed(), id: \.id) { commentInAllComments in
                    
                        NavigationLink(destination: ActivityDetailsView(activity: commentInAllComments.activity, commentsStore: commentsStore)) {
                            HStack {
                                Text(commentInAllComments.date)
                                Spacer()
                                Text(commentInAllComments.activity.title)
                                Spacer()
                                Text(commentInAllComments.activity.role?.rawValue ?? "")
                                Spacer()
                                Text(commentInAllComments.comment)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                        }
                        .simultaneousGesture(TapGesture().onEnded{
                            commentsStore.nameForDetailsFile = commentInAllComments.activity.id.uuidString
                            Task {
                                do {
                                    try await commentsStore.loadComments()
                                }
                            }
                        })
                    }
                }
            }
        }
    }
}

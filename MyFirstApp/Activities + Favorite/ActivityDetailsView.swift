import SwiftUI

struct ActivityDetailsView: View {
    let activity: Activity
    @ObservedObject var commentsStore: ActivityDetailStore
    @State private var newComment: String = ""
    
    var body: some View {
        VStack {
            activityDetails
            commentsScroll
            enterNewComment
        }
        .task {
            do {
                try await commentsStore.loadComments(for: commentsStore.fileURL(nameForDetailsFile: activity.id.uuidString))
            } catch {
                print("always handle errors")
            }
        }
    }
    
    @ViewBuilder private var activityDetails: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("activity_title"))
                Spacer()
                Text(activity.title)
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text(LocalizedStringKey("activity_significance"))
                Spacer()
                Text(LocalizedStringKey(activity.significance?.rawValue ?? ""))
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text(LocalizedStringKey("activity_duration"))
                Spacer()
                Text("\(activity.duration)")
                Text(LocalizedStringKey("activity_duration_unity_of_measure"))
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 20)
        .font(.title2)
    }
    
    @ViewBuilder private var commentsScroll: some View {
        ScrollView {
            VStack(alignment: .trailing) {
                ForEach(commentsStore.comments, id: \.id) { comment in
                    HStack {
                        Text(comment.date)
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
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder private var enterNewComment: some View {
        HStack {
            TextField(LocalizedStringKey("enter_comment"), text: $newComment)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
        }
        
        Button(action: {
            sendComment()
        }) {
            Text(LocalizedStringKey("send_text"))
        }
        .padding()
    }
    
    
    func sendComment() {
        guard !newComment.isEmpty else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let currentTime = dateFormatter.string(from: Date())
        let newComment = Comment(comment: self.newComment, date: currentTime, activity: self.activity)
        Task {
            do {
                let fileURL = try commentsStore.fileURL(nameForDetailsFile: activity.id.uuidString)
                
                try await commentsStore.saveComment(newComment, for: fileURL)
                try await commentsStore.saveCommentInAllComments(newComment)
                self.newComment = ""
                try await commentsStore.loadComments(for: fileURL)
            } catch {
                print(error)
            }
        }
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity.emptyActivity
        let commentsStore = ActivityDetailStore()
        
        ActivityDetailsView(activity: activity, commentsStore: commentsStore)
    }
}

import SwiftUI

struct ActivityDetailsView: View {
    var activity: Activity
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    @State private var newComment: String = ""
    
    var body: some View {
        VStack {
            activityDetails
            commentsScroll
            enterNewComment
        }
        .task {
            do {
                try accountsStore.loadAccounts()
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
        .font(.title2)
    }
    
    @ViewBuilder private var commentsScroll: some View {
        
        VStack(alignment: .trailing) {
            List {
                ForEach(activity.comments, id: \.id) { comment in
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
                .padding(.horizontal, 20)
            }
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
            newComment = ""
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
        let newComment = Comment(comment: self.newComment, date: currentTime)
        Task {
            do {
                try await accountsStore.addComment(newComment: newComment, for: activity, in: selectedAccount)
                try accountsStore.loadAccounts()
            } catch {
                print(error)
            }
        }
    }
}

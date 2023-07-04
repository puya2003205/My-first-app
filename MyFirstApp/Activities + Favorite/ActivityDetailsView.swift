import SwiftUI



struct ActivityDetailsView: View {
    let activity: Activity
    @State private var comments: [String] = []
    @State private var newComment: String = ""
    
    
    var body: some View {
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
        
        
        
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        ForEach(comments, id: \.self) { comment in
                            Text(comment)
                                .padding(20)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.trailing, 20)
            }
        }
        HStack{
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
        
        comments.append(newComment)
        newComment = ""
    }
}


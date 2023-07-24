import SwiftUI

struct AllComments: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    
    var body: some View {
        VStack(alignment: .trailing) {
            List {
                ForEach(selectedAccount.activities.reversed(), id: \.id) { activity in
                    ForEach(activity.comments, id: \.id) { comment in
                        NavigationLink(destination: ActivityDetailsView(activity: activity, accountsStore: accountsStore, selectedAccount: selectedAccount)) {
                            CommentCard(activity: activity, comment: comment)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}

import SwiftUI

struct AllComments: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    
    var body: some View {
        VStack(alignment: .trailing) {
            List {
                ForEach(selectedAccount.activities.reversed(), id: \.id) { commentInAllComments in
                    NavigationLink(destination: ActivityDetailsView(activity: commentInAllComments, accountsStore: accountsStore, selectedAccount: selectedAccount)) {
                        CommentCard(activity: commentInAllComments)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
    
}

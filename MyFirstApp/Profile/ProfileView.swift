import SwiftUI

struct ProfileView: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account

    var body: some View {
            ProfileCard(selectedAccount: selectedAccount, accountsStore: accountsStore)
    }
    
}

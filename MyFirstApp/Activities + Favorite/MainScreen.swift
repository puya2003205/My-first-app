import SwiftUI

struct MainScreen: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    var selectedRole: ActivityRole
    
    var body: some View {
        mainScreen
    }
    
    @ViewBuilder private var mainScreen: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(selectedAccount.activities) { activity in
                    if activity.role == selectedRole {
                        ActivityCardWithAnimation(accountsStore:accountsStore, selectedAccount: selectedAccount, activity: activity)
                    }
                }
            }
            Spacer()
        }
    }
}

import SwiftUI

class NavigationTabViewModel: ObservableObject {
    @Published var selectedTab: TabItemElement = .explore
    @Published var isPresentingNewActivityView = false
    @Published var selectedRole: ActivityRole = .frontend
    @Published var isPresentingEditProfile = false
    @Published var editingProfile = Account.emptyAccount
    
    let accountsStore: AccountsStore
    let selectedAccount: Account
    
    init(accountsStore: AccountsStore, selectedAccount: Account) {
        self.accountsStore = accountsStore
        self.selectedAccount = selectedAccount
    }
    
    func selectionRolesStyle() -> some View {
        Group {
            if selectedTab == .explore {
                if selectedRole == .ios {
                    Text(selectedRole.rawValue.uppercased())
                        .padding(.top, 20)
                        .font(.title)
                } else {
                    Text(selectedRole.rawValue.capitalized)
                        .padding(.top, 20)
                        .font(.title)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    func confirmationAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let alertController = UIAlertController(title: "Confirmation", message: NSLocalizedString("favorites_delete_message", comment: ""), preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            Task {
                try await self.accountsStore.clearFavorites(for: self.selectedAccount)
                try await self.accountsStore.clearComments(for: self.selectedAccount)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        if let window = windowScene.windows.first {
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

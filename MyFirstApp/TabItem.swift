import SwiftUI

struct TabItem: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    
    @State private var selectedTab: TabItemElement = .explore
    @State private var isPresentingNewActivityView = false
    @State private var selected: ActivityRole = .frontend
    @State private var isPresentingEditProfile = false
    @State private var editingProfile = Account.emptyAccount
    
    private enum TabItemElement: Int, CaseIterable, Hashable {
        case favorites
        case explore
        case profile
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedTab == .explore {
                    if selected == .ios {
                        Text(selected.rawValue.uppercased())
                            .padding(.top, 20)
                            .font(.title)
                    } else {
                        Text(selected.rawValue.capitalized)
                            .padding(.top, 20)
                            .font(.title)
                    }
                }
                tabView
                    .toolbar {
                        switch selectedTab {
                        case .favorites:
                            ToolbarItem(placement: .navigationBarTrailing) {
                                deleteFavoritesButton
                            }
                            
                        case .explore:
                            ToolbarItem(placement: .navigationBarLeading) {
                                menu
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                addNewActivityButton
                            }
                        case .profile:
                            ToolbarItem(placement: .navigationBarTrailing) {
                                editProfileButton
                            }
                        }
                    }
                    .onChange(of: selectedTab) { tab in
                        if tab == .favorites {
                            Task {
                                accountsStore.loadAccounts
                            }
                        }
                    }
                    .sheet(isPresented: $isPresentingNewActivityView){
                        NewActivity(isPresentingNewActivity: $isPresentingNewActivityView, accountsStore: accountsStore, selectedAccount: selectedAccount, pozitie: selected.rawValue)
                    }
                    .sheet(isPresented: $isPresentingEditProfile) {
                        ProfileFormView(selectedAccount: $editingProfile, accountsStore:accountsStore, isPresentingEditProfile: $isPresentingEditProfile)
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder private var tabView: some View {
        TabView(selection: $selectedTab) {
            FavoritesView(accountsStore: accountsStore, selectedAccount: selectedAccount)
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(TabItemElement.favorites)
            
            MainScreen(accountsStore: accountsStore, selectedAccount: selectedAccount, selectedRole: selected)
                .tabItem {
                    Label("Explore", systemImage: "safari.fill")
                }
                .tag(TabItemElement.explore)
            
            ProfileView(accountsStore: accountsStore, selectedAccount: selectedAccount)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(TabItemElement.profile)
        }
    }
    
    @ViewBuilder private var menu: some View {
        Menu {
            ForEach(ActivityRole.allCases, id: \.self) { activityRole in
                Button(action: { selected = activityRole }) {
                    Label(
                        title: {
                            if activityRole == .ios {
                                Text(activityRole.rawValue.uppercased())
                            } else {
                                Text(activityRole.rawValue.capitalized)
                            }
                        },
                        icon: {
                            if selected == activityRole {
                                Image(systemName: "checkmark.circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                        }
                    )
                }
            }
        }
    label: { Image(systemName: "arrow.up.arrow.down.circle") }
            .accessibilityLabel("Selectie")
            .font(.system(size: 20))
            .padding(5)
    }
    
    @ViewBuilder private var addNewActivityButton: some View {
        Button(action: {
            isPresentingNewActivityView = true
        }) {
            Image(systemName: "plus")
        }
        .accessibilityLabel("New Activity")
        .font(.system(size: 20))
        .padding(5)
    }
    
    @ViewBuilder private var deleteFavoritesButton: some View {
        Button(action: {
            confirmationAlert()
        }) {
            Image(systemName: "trash.circle")
        }
        .accessibilityLabel("New Activity")
        .font(.system(size: 20))
        .padding(5)
    }
    
    @ViewBuilder private var editProfileButton: some View {
        Button(action: {
            isPresentingEditProfile = true
        }) {
            Image(systemName: "square.and.pencil.circle.fill")
        }
        .accessibilityLabel("Edit Profile")
        .font(.system(size: 20))
        .padding(5)
    }
    
    private func confirmationAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let alertController = UIAlertController(title: "Confirmation", message: NSLocalizedString("favorites_delete_message", comment: ""), preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            Task {
                try await accountsStore.clearFavorites(for: selectedAccount)
                try await accountsStore.clearComments(for: selectedAccount)
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

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        let accountsStore = AccountsStore()
        let selectedAccount = Account.sampleData
        
        TabItem(accountsStore: accountsStore, selectedAccount: selectedAccount)
    }
}

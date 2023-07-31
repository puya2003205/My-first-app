import SwiftUI

struct NavigationTabView: View {
    @ObservedObject var viewModel: NavigationTabViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                viewModel.selectionRolesStyle()
                
                tabView
                    .toolbar {
                        switch viewModel.selectedTab {
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
                    .onChange(of: viewModel.selectedTab) { tab in
                        if tab == .favorites {
                            Task {
                                viewModel.accountsStore.loadAccounts
                            }
                        }
                    }
                    .sheet(isPresented: $viewModel.isPresentingNewActivityView){
                        NewActivity(
                            isPresentingNewActivity: $viewModel.isPresentingNewActivityView,
                            accountsStore: viewModel.accountsStore,
                            selectedAccount: viewModel.selectedAccount,
                            pozitie: viewModel.selectedRole.rawValue
                        )
                    }
                    .sheet(isPresented: $viewModel.isPresentingEditProfile) {
                        ProfileFormView(
                            selectedAccount: $viewModel.editingProfile,
                            accountsStore: viewModel.accountsStore,
                            isPresentingEditProfile: $viewModel.isPresentingEditProfile)
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder private var tabView: some View {
        TabView(selection: $viewModel.selectedTab) {
            FavoritesView(accountsStore: viewModel.accountsStore, selectedAccount: viewModel.selectedAccount)
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(TabItemElement.favorites)
            
            MainScreen(accountsStore: viewModel.accountsStore, selectedAccount: viewModel.selectedAccount, selectedRole: viewModel.selectedRole)
                .tabItem {
                    Label("Explore", systemImage: "safari.fill")
                }
                .tag(TabItemElement.explore)
            
            ProfileView(accountsStore: viewModel.accountsStore, selectedAccount: viewModel.selectedAccount)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(TabItemElement.profile)
        }
    }
    
    @ViewBuilder private var menu: some View {
        Menu {
            ForEach(ActivityRole.allCases, id: \.self) { activityRole in
                Button(action: { viewModel.selectedRole = activityRole }) {
                    Label(
                        title: {
                            if activityRole == .ios {
                                Text(activityRole.rawValue.uppercased())
                            } else {
                                Text(activityRole.rawValue.capitalized)
                            }
                        },
                        icon: {
                            if viewModel.selectedRole == activityRole {
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
            viewModel.isPresentingNewActivityView = true
        }) {
            Image(systemName: "plus")
        }
        .accessibilityLabel("New Activity")
        .font(.system(size: 20))
        .padding(5)
    }
    
    @ViewBuilder private var deleteFavoritesButton: some View {
        Button(action: {
            viewModel.confirmationAlert()
        }) {
            Image(systemName: "trash.circle")
        }
        .accessibilityLabel("New Activity")
        .font(.system(size: 20))
        .padding(5)
    }
    
    @ViewBuilder private var editProfileButton: some View {
        Button(action: {
            viewModel.isPresentingEditProfile = true
        }) {
            Image(systemName: "square.and.pencil.circle.fill")
        }
        .accessibilityLabel("Edit Profile")
        .font(.system(size: 20))
        .padding(5)
    }
    
    
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        let accountsStore = AccountsStore()
        let selectedAccount = Account.sampleData
        
        
        NavigationTabView(viewModel: NavigationTabViewModel(accountsStore: accountsStore, selectedAccount: selectedAccount))
    }
}

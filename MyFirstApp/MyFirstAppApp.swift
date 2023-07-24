import SwiftUI

@main
struct MyFirstAppApp: App {
    @State private var navigationScreen = [NavigationScreen]()
    @StateObject private var accountsStore = AccountsStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationScreen) {
                HelloScreenView(accountsStore: accountsStore, goToLogin: { navigationScreen.append(.login)} )
                    .task {
                        do {
                            try accountsStore.loadAccounts()
                        } catch {
                            print(error)
                        }
                    }
                    .navigationDestination(for: NavigationScreen.self) { screens in
                        switch screens {
                        case .login:
                            LoginScreenView(
                                accountsStore: accountsStore,
                                goToRegister: { navigationScreen.append(.register)}
                            )
                        case .register:
                            RegisterScreenView(
                                accountsStore: accountsStore,
                                goBackToLogin: { navigationScreen.removeLast()}
                            )
                        }
                    }
            }
        }
    }
}

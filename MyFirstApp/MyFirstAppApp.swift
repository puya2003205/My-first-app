import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var accountsStore = AccountsStore()
    
    var body: some Scene {
        
        WindowGroup {
            HelloScreenView(accountsStore: accountsStore)
                .task {
                    do {
                        try accountsStore.loadAccounts()
                    } catch {
                        print(error)
                    }
                }
        }
    }
}

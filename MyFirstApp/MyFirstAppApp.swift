import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var store = DataStore()
   
    var body: some Scene {
    
        WindowGroup {
            TabItem(activityStore: store)
            .task {
                do {
                    try await store.loadActivity()
                    try await store.loadProfile()
                } catch {
                    print(error)
                }
            }
        }
    }
}

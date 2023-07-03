import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var store = ActivityStore()
   
    var body: some Scene {
    
        WindowGroup {
            TabItem(activityStore: store)
            .task {
                do {
                    try await store.load()
                    try await store.loadProfile()
                } catch {
                    print(error)
                }
            }
        }
    }
}

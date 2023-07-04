import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var activityStore = ActivityStore()
    @StateObject private var profileStore = ProfileStore()
    
    var body: some Scene {
    
        WindowGroup {
            TabItem(activityStore: activityStore, profileStore: profileStore)
            .task {
                do {
                    try await activityStore.loadActivity()
                    try await profileStore.loadProfile()
                } catch {
                    print(error)
                }
            }
        }
    }
}

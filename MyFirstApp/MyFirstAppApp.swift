import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var activityStore = ActivityStore()
    @StateObject private var profileStore = ProfileStore()
    @StateObject private var commentsStore = ActivityDetailStore()
    
    var body: some Scene {
    
        WindowGroup {
            TabItem(activityStore: activityStore, profileStore: profileStore, commentsStore: commentsStore)
            .task {
                do {
                    try await activityStore.loadActivity()
                    try await profileStore.loadProfile()
                } catch {
                    print(error)
                }
            }
         //   HelloScreenView()
        }
    }
}

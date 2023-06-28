import SwiftUI

@main
struct MyFirstAppApp: App {
    @StateObject private var store = ActivityStore()
    var body: some Scene {
    
        WindowGroup {
            TabItem(activityStore: store) {
                Task {
                    do {
                        try await store.save(activitati: store.activitati)
                    } catch {
                        
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    print(error)
                }
            }
        }
    }
}

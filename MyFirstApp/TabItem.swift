import SwiftUI

struct TabItem: View {
    @StateObject var activityStore: ActivityStore
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedTab = 1
    @State private var isPresentingNewActivityView = false

    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                FavoritesView(activityStore: activityStore)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(0)
                
                MainScreen(activityStore: activityStore)
                    .tabItem {
                        Label("Explore", systemImage: "safari.fill")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    }
                    .tag(2)
            }
            .toolbar {
                if selectedTab == 1 {
                    Button(action: {
                        isPresentingNewActivityView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Activity")
                }
            }
            .sheet(isPresented: $isPresentingNewActivityView){
                NewActivitySheet(isPresentingNewScrumView: $isPresentingNewActivityView, activityStore: activityStore)
            }
        }
    }
}

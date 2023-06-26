import SwiftUI

struct TabItem: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FavoritesView(activities: .constant(Activity.sampleData))
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(0)
            
            MainScreen()
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
    }
}
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabItem()
    }
}

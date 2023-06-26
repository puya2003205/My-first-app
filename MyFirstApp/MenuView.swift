import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                
                NavigationLink(destination: FavoritesView(activities: .constant(Activity.sampleData))) {
                    MenuItem(imageName: "star", title: "Favorites")
                }
                
                MenuItem(imageName: "safari.fill", title: "Explore")
                
                NavigationLink(destination: ProfileView()) {
                    MenuItem(imageName: "person.crop.circle", title: "Profile")
                }
            }
            .frame(height: 80)
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MenuItem: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}



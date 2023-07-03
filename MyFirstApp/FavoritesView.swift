import SwiftUI

struct FavoritesView: View {
    @StateObject var activityStore: ActivityStore
    
    var body: some View {
        ScrollView {
            VStack {
                if (activityStore.favorite == []) {
                    FavoriteViewNil()
                } else {
                        Section(header: Text("Frontend")) {
                            if activityStore.favorite.filter ({ $0.pozitie == "frontend" }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.titlu) { activity in
                                    if activity.pozitie == "frontend" {
                                        ActivityCard(activity: activity, color: .blue)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Backend")) {
                            if activityStore.favorite.filter({ $0.pozitie == "backend" }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.titlu) { activity in
                                    if activity.pozitie == "backend" {
                                        ActivityCard(activity: activity, color: .blue)
                                    }
                                }
                            }
                        }
                        Section(header: Text("DevOps")) {
                            if activityStore.favorite.filter({ $0.pozitie == "devops" }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.titlu) { activity in
                                    if activity.pozitie == "devops" {
                                        ActivityCard(activity: activity, color: .blue)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Android")) {
                            if activityStore.favorite.filter({ $0.pozitie == "android" }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.titlu) { activity in
                                    if activity.pozitie == "android" {
                                        ActivityCard(activity: activity, color: .blue)
                                    }
                                }
                            }
                        }
                        Section(header: Text("IOS")) {
                            if activityStore.favorite.filter({ $0.pozitie == "ios" }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.titlu) { activity in
                                    if activity.pozitie == "ios" {
                                        ActivityCard(activity: activity, color: .blue)
                                    }
                                }
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct FavoriteViewNil: View {
    var body: some View {
        HStack {
            Text("Din pacate inca nu ai introdus nicio activitate in categoria favorite, te poti intoarce pe pagina explore si sa dai swipe right activitatilor pe care vrei sa le faci azi!")
            .multilineTextAlignment(.center)
            .padding(50)
            .font(.title2)
        }
    }
}

struct FavoritesCategoryNil: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text("Inca nu ai adaugat nicio activitate la aceasta categorie")
                    .font(.title)
                    .multilineTextAlignment(.center)
                  
                Spacer()
            }
            .padding(.vertical, 5)
        }
        .padding(20)
        .background(Color.blue.opacity(0.5))
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

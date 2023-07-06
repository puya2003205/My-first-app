import SwiftUI

struct FavoritesView: View {
    @ObservedObject var activityStore: ActivityStore
    @ObservedObject var commentsStore: ActivityDetailStore
    
    var body: some View {
        ScrollView {
            VStack {
                if (activityStore.favorite == []) {
                    FavoriteViewNil()
                } else {
                    
                    ForEach(ActivityRole.allCases, id: \.self) { activityRole in
                        Section(header: Text(activityRole.rawValue)) {
                            if activityStore.favorite.filter ({ $0.role == activityRole }).count == 0 {
                                FavoritesCategoryNil()
                            } else {
                                ForEach(activityStore.favorite, id: \.title) { activity in
                                    if activity.role == activityRole {
                                        NavigationLink(destination: ActivityDetailsView(activity: activity, commentsStore: commentsStore)) {
                                            ActivityCard(activity: activity, color: .blue)
                                        }
                                        .simultaneousGesture(TapGesture().onEnded{
                                            commentsStore.nameForDetailsFile = activity.id.uuidString
                                            Task {
                                                do {
                                                    try await commentsStore.loadComments()
                                                } catch {
                                                    print(error)
                                                }
                                            }
                                        })
                                    }
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
            Text(LocalizedStringKey("favorites_no_activity"))
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
                Text(LocalizedStringKey("favorites_no_activity_on_category"))
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

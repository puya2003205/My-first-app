import SwiftUI

struct FavoritesView: View {
    @StateObject var activityStore: ActivityStore
    
    var body: some View {
        List(activityStore.activitati, id: \.titlu) { activity in
            if activity.status == true {
                ActivityCard(activity: activity, color: .blue)
            }
        }
    }
}

//struct Favorites_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(activities: .constant(Activity.sampleData))
//    }
//}

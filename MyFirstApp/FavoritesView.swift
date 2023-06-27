import SwiftUI

struct FavoritesView: View {
    @Binding var activities: [Activity]
    var body: some View {
        List(activities, id: \.titlu) { activity in
            if activity.status == true {
                ActivityCard(activity: activity, color: .blue)
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(activities: .constant(Activity.sampleData))
    }
}

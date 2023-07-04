import SwiftUI

struct MainScreen: View {
    @StateObject var activityStore: DataStore
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(activityStore.activitati) { activity in
                        ActivityCardWithAnimation(activity: activity)
                    }
                }
            Spacer()
        }
    }
}

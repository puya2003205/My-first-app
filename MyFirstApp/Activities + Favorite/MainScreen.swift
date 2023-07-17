import SwiftUI

struct MainScreen: View {
    @ObservedObject var activityStore: ActivityStore
    
    var body: some View {
        mainScreen
    }
    
    @ViewBuilder private var mainScreen: some View {
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

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        let activityStore = ActivityStore()
        
        MainScreen(activityStore: activityStore)
    }
}

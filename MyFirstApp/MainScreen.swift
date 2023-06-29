import SwiftUI

struct MainScreen: View {
    @StateObject var activityStore: ActivityStore
    @Environment(\.scenePhase) private var scenePhase
    @State private var currentIndex = 0
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            Text("Salut")
                .font(.title)
                .padding(.top, 50)
            Spacer()
            ZStack {
                ForEach(activityStore.activitati, id: \.titlu) { activity in
                        ActivityCardWithAnimation(activity: activity)
                    }
                }
            Spacer()
        }
    }
}

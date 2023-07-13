import SwiftUI

struct ActivityCard: View {
    @State var activity: Activity
    @State private var offset = CGSize.zero
    var color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            activityTitle
            activitySignificance
            activityDuration
        }
        .padding(20)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
    @ViewBuilder private var activityTitle: some View {
        HStack {
            Spacer()
            Text(LocalizedStringKey("activity_title"))
                .font(.title)
            Text(activity.title)
                .font(.title2)
            Spacer()
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder private var activitySignificance: some View {
        HStack {
            Spacer()
            Text(LocalizedStringKey("activity_significance"))
                .font(.title)
            Text(LocalizedStringKey(activity.significance?.rawValue ?? ""))
                .font(.title2)
            Spacer()
        }
        .padding(.bottom, 10)
    }

    @ViewBuilder private var activityDuration: some View {
        HStack {
            Spacer()
            Text(LocalizedStringKey("activity_duration"))
                .font(.title)
            HStack {
                Text("\(activity.duration)")
                Text(LocalizedStringKey("activity_duration_unity_of_measure"))
            }
                .font(.title2)
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

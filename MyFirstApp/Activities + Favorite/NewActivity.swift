import SwiftUI

struct ActivityView: View {
    @Binding var activity: Activity
    @State private var selectedOption: ActivitySignificance?
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("create_activity_label"))) {
                TextField(LocalizedStringKey("activity_title"), text: $activity.title)
            }
            Section{
                HStack{
                    Menu(LocalizedStringKey("activity_significance")) {
                        
                        ForEach(ActivitySignificance.allCases) { activitySignificance in
                            Button(action: {
                                selectedOption = activitySignificance
                                activity.significance = selectedOption
                            }) {
                                Text(LocalizedStringKey(activitySignificance.rawValue))
                            }
                        }
                    }
                    Spacer()
                    Text(LocalizedStringKey(selectedOption?.rawValue ?? ""))
                }
            }
            Section {
                HStack{
                    Text(LocalizedStringKey("activity_duration"))
                    Slider(value: $activity.durationDouble, in: 0...8, step: 0.5) {
                        Text(LocalizedStringKey("activity_duration"))
                    }
                    Spacer()
                    HStack {
                        Text("\(activity.duration)")
                        Text(LocalizedStringKey("activity_duration_unity_of_measure"))
                    }
                        .accessibilityHidden(true)
                }
            }
        }
    }
}

struct NewActivitySheet: View {
    @State private var newActivity = Activity.emptyActivity
    @Binding var isPresentingNewActivity: Bool
    @ObservedObject var activityStore: ActivityStore
    @State var pozitie: String = ""
    
    var body: some View {
        NavigationStack {
            ActivityView(activity: $newActivity)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewActivity = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            guard !newActivity.title.isEmpty else { return }
                            guard newActivity.significance != nil else { return }
                            guard newActivity.duration > 0 else { return }
                            
                            setPozitie()
                            Task {
                                try await activityStore.saveActivity(newActivity)
                            }
                            isPresentingNewActivity = false
                        }
                        
                    }
                }
        }
    }
    func setPozitie() {
        if let role = ActivityRole(rawValue: pozitie){
            newActivity.role = role
        }
    }
}

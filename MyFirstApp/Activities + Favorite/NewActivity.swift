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
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
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
                            for buttonGuardCondition in SaveNewActivityAlert.allCases {
                                guard evaluateButtonGuardCondition(buttonGuardCondition) else {
                                    createSaveNewActivityAlert(ofType: buttonGuardCondition)
                                    return
                                }
                            }
                            
                            setPozitie()
                            Task {
                                try await activityStore.saveActivity(newActivity)
                            }
                            isPresentingNewActivity = false
                        }
                        
                    }
                }
                .alert(isPresented: $showAlert) {
                                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                }
        }
    }
    
    private func evaluateButtonGuardCondition(_ buttonGuardCondition: SaveNewActivityAlert) -> Bool {
        switch buttonGuardCondition {
        case .title:
            return !newActivity.title.isEmpty
        case .significance:
            return newActivity.significance != nil
        case .duration:
            return newActivity.duration > 0
        }
    }
    
    private func createSaveNewActivityAlert(ofType: SaveNewActivityAlert) {
        alertTitle = NSLocalizedString(ofType.title, comment: "")
        alertMessage = NSLocalizedString(ofType.message, comment: "")
        showAlert = true
    }
    
    private func setPozitie() {
        if let role = ActivityRole(rawValue: pozitie){
            newActivity.role = role
        }
    }
}

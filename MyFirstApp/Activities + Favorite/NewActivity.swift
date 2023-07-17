import SwiftUI

struct NewActivity: View {
    @State private var newActivity = Activity.emptyActivity
    @Binding var isPresentingNewActivity: Bool
    @ObservedObject var activityStore: ActivityStore
    @State var pozitie: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            ActivityForm(activity: $newActivity)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        dismissButton
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        addButton
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
    }
    
    @ViewBuilder private var dismissButton: some View {
        Button("Dismiss") {
            isPresentingNewActivity = false
        }
    }
    
    @ViewBuilder private var addButton: some View {
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

struct NewActivity_Previews: PreviewProvider {
    @State static var isPresentingNewActivity = true
    
    static var previews: some View {
        let activityStore = ActivityStore()

        NewActivity(isPresentingNewActivity: $isPresentingNewActivity, activityStore: activityStore)
    }
}

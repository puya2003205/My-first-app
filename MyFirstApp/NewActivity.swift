import SwiftUI


struct ActivityView: View {
    @Binding var activity: Activity
    @State private var selectedOption: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Activity Info")) {
                TextField("Titlu", text: $activity.titlu)
            }
            Section{
                HStack{
                    Menu("Importanta") {
                        Button(action: {
                            selectedOption = "Mica"
                            setImportantaValue()
                        }) {
                            Text("Mica")
                        }
                        Button(action: {
                            selectedOption = "Medie"
                            setImportantaValue()
                        }) {
                            Text("Medie")
                        }
                        Button(action: {
                            selectedOption = "Mare"
                            setImportantaValue()
                        }) {
                            Text("Mare")
                        }
                        Button(action: {
                            selectedOption = "Urgenta"
                            setImportantaValue()
                        }) {
                            Text("Urgenta")
                        }
                    }
                    Spacer()
                    Text(selectedOption)
                }
            }
            Section {
                HStack{
                    Text("Durata")
                    Slider(value: $activity.durataDouble, in: 0...8, step: 0.5) {
                        Text("Durata")
                    }
                    Spacer()
                    Text("\(activity.durata) ore")
                        .accessibilityHidden(true)
                }
            }
        }
    }
    
    func setImportantaValue() {
        activity.importanta = selectedOption
        }
}

struct NewActivitySheet: View {
    @State private var newActivity = Activity.emptyActivity
    @Binding var isPresentingNewActivity: Bool
    @StateObject var activityStore: ActivityStore
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
                            if newActivity.titlu != "" {
                                if newActivity.importanta != "" {
                                    if newActivity.durata > 0 {
                                        setPozitie()
                                        Task {
                                            try await activityStore.save(activitate: newActivity)
                                        }
                                        isPresentingNewActivity = false
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    func setPozitie() {
        newActivity.pozitie = pozitie
        }
}

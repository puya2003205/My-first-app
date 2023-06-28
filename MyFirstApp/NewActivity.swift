import SwiftUI


struct ActivityView: View {
    @Binding var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Activity Info")) {
                TextField("Titlu", text: $activity.titlu)
                HStack{
                    Slider(value: $activity.distantaDouble, in: 1...130, step: 1) {
                        Text("Distanta")
                    }
                    Spacer()
                    Text("\(activity.distanta) km")
                        .accessibilityHidden(true)
                }
                Slider(value: $activity.startHourDouble, in: 8...15, step: 1) {
                    Text("StartHour")
                }
                Toggle(isOn: $activity.status) {
                }
            }
        }
    }
}

struct NewActivitySheet: View {
    @State private var newActivity = Activity.emptyActivity
    @State var activities: [Activity]
    @Binding var isPresentingNewScrumView: Bool
    var body: some View {
        NavigationStack {
            ActivityView(activity: $newActivity)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            activities.append(newActivity)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}



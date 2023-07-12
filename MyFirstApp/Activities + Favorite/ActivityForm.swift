import SwiftUI

struct ActivityForm: View {
    @Binding var activity: Activity
    @State private var selectedOption: ActivitySignificance?
    
    var body: some View {
        Form {
            activityFormTitle
            activityFormSignificance
            activityFormDuration
        }
    }
    
    @ViewBuilder private var activityFormTitle: some View {
        Section(header: Text(LocalizedStringKey("create_activity_label"))) {
            TextField(LocalizedStringKey("activity_title"), text: $activity.title)
        }
    }
    
    @ViewBuilder private var activityFormSignificance: some View {
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
    }
    
    @ViewBuilder private var activityFormDuration: some View {
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

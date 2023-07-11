import SwiftUI

struct ProfileFormView: View {
    @Binding var profile: Profile
    @ObservedObject var profileStore: ProfileStore
    @Binding var isPresentingEditProfile: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("update_profile_personal_information"))) {
                    TextField(LocalizedStringKey("update_profile_name"), text: $profile.name)
                    TextField(LocalizedStringKey("profile_role"), text: $profile.role)
                    TextField(LocalizedStringKey("profile_gender"), text: $profile.gender)
                    DatePicker(LocalizedStringKey("profile_date_of_birth"), selection: $profile.dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text(LocalizedStringKey("update_profile_contact_information"))) {
                    TextField(LocalizedStringKey("profile_email"), text: $profile.email)
                }
                
                Section {
                    Button(LocalizedStringKey("update_profile_save_profile")) {
                        Task {
                            try await profileStore.updateProfile(profile)
                            isPresentingEditProfile = false
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("update_profile_update_profile"))
        }
    }
}

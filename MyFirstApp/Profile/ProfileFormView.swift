import SwiftUI

struct ProfileFormView: View {
    @Binding var profile: Profile
    @ObservedObject var profileStore: ProfileStore
    @Binding var isPresentingEditProfile: Bool
    @State private var selectedGender: ProfileGender?
    @State private var selectedRole: ActivityRole?
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("update_profile_personal_information"))) {
                    TextField(LocalizedStringKey("update_profile_name"), text: $profile.name)
                    HStack{
                        Text(profile.role?.rawValue.capitalized ?? NSLocalizedString("profile_role", comment: ""))
                        Spacer()
                        Menu {
                            ForEach(ActivityRole.allCases) { profileRole in
                                Button(action: {
                                    selectedRole = profileRole
                                    profile.role = selectedRole
                                }) {
                                    Text(profileRole.rawValue.capitalized)
                                }
                            }
                        }
                        label: {
                            Image(systemName: "arrow.down")
                        }
                    }
                    HStack{
                        Text(profile.gender?.rawValue.capitalized ?? NSLocalizedString("profile_gender", comment: ""))
                        Spacer()
                        Menu {
                            
                            ForEach(ProfileGender.allCases) { profileGender in
                                Button(action: {
                                    selectedGender = profileGender
                                    profile.gender = selectedGender
                                }) {
                                    Text(profileGender.rawValue.capitalized)
                                }
                            }
                        }
                        label: {
                            Image(systemName: "arrow.down")
                        }
                    }
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

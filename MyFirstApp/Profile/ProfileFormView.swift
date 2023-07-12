import SwiftUI

struct ProfileFormView: View {
    @Binding var profile: Profile
    @ObservedObject var profileStore: ProfileStore
    @Binding var isPresentingEditProfile: Bool
    @State private var selectedGender: ProfileGender?
    @State private var selectedRole: ActivityRole?
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("update_profile_personal_information"))) {
                    TextField(LocalizedStringKey("update_profile_name"), text: $profile.name)
                        .autocorrectionDisabled()
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
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                
                Section {
                    Button(LocalizedStringKey("update_profile_save_profile")) {
                        guard profile.name.count >= 2 else {
                            createSaveEditedProfileAlert(ofType: .minimumLetters)
                            return
                        }
                        
                        guard profile.name.count <= 35 else {
                            createSaveEditedProfileAlert(ofType: .maximumLetters)
                            return
                        }
                        
                        guard profile.role != nil else {
                            createSaveEditedProfileAlert(ofType: .role)
                            return
                        }
                        
                        guard profile.gender != nil else {
                            createSaveEditedProfileAlert(ofType: .gender)
                            return
                        }
                        
                        guard isValidEmailAddress(emailAddress: profile.email) else {
                            createSaveEditedProfileAlert(ofType: .validEmail)
                            return
                        }
                        
                        Task {
                            try await profileStore.updateProfile(profile)
                            isPresentingEditProfile = false
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("update_profile_update_profile"))
        }
    }
    
    private func createSaveEditedProfileAlert(ofType: SaveEditedProfileAlert) {
        alertMessage = NSLocalizedString(ofType.message, comment: "")
        showAlert = true
    }
    
    private func isValidEmailAddress(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: emailAddress.count))
            
            return !results.isEmpty
        } catch {
            return false
        }
    }
}

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
                    updateName
                    updateRole
                    updateGender
                    updateBirthDate
                }
                
                Section(header: Text(LocalizedStringKey("update_profile_contact_information"))) {
                    updateEmail
                }
                
                Section {
                    saveButton
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
            }
        }
        .navigationBarTitle(LocalizedStringKey("update_profile_update_profile"))
    }
    
    @ViewBuilder private var updateName: some View {
        TextField(LocalizedStringKey("update_profile_name"), text: $profile.name)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var updateRole: some View {
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
        label: { Image(systemName: "arrow.down") }
        }
    }
    
    @ViewBuilder private var updateGender: some View {
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
        label: { Image(systemName: "arrow.down") }
        }
    }
    
    @ViewBuilder private var updateBirthDate: some View {
        DatePicker(LocalizedStringKey("profile_date_of_birth"), selection: $profile.dateOfBirth, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
    }
    
    @ViewBuilder private var updateEmail: some View {
        TextField(LocalizedStringKey("profile_email"), text: $profile.email)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var saveButton: some View {
        Button(LocalizedStringKey("update_profile_save_profile")) {
            for buttonGuardCondition in SaveEditedProfileAlert.allCases {
                guard evaluateButtonGuardCondition(buttonGuardCondition) else {
                    createSaveEditedProfileAlert(ofType: buttonGuardCondition)
                    return
                }
            }
            
            Task {
                try await profileStore.updateProfile(profile)
                isPresentingEditProfile = false
            }
        }
    }
    
    private func evaluateButtonGuardCondition(_ buttonGuardCondition: SaveEditedProfileAlert) -> Bool {
        switch buttonGuardCondition {
        case .minimumLetters:
            return profile.name.count >= 2
        case .maximumLetters:
            return profile.name.count <= 35
        case .role:
            return profile.role != nil
        case .gender:
            return profile.gender != nil
        case .validEmail:
            return isValidEmailAddress(emailAddress: profile.email)
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


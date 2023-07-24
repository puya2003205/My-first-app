import SwiftUI

struct ProfileFormView: View {
    @Binding var selectedAccount: Account
    @ObservedObject var accountsStore: AccountsStore
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
                
                saveButton
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
            }
            
            .navigationTitle(Text(LocalizedStringKey("update_profile_update_profile")))
        }
    }
    
    @ViewBuilder private var updateName: some View {
        TextField(LocalizedStringKey("update_profile_name"), text: $selectedAccount.profile.name)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var updateRole: some View {
        HStack {
            Text(selectedAccount.profile.role?.rawValue.capitalized ?? NSLocalizedString("profile_role", comment: ""))
            
            Spacer()
            
            Menu {
                ForEach(ActivityRole.allCases) { profileRole in
                    Button(action: {
                        selectedRole = profileRole
                        selectedAccount.profile.role = selectedRole
                    }) {
                        Text(profileRole.rawValue.capitalized)
                    }
                }
            }
        label: { Image(systemName: "arrow.down") }
        }
    }
    
    @ViewBuilder private var updateGender: some View {
        HStack {
            Text(selectedAccount.profile.gender?.rawValue.capitalized ?? NSLocalizedString("profile_gender", comment: ""))
            
            Spacer()
            
            Menu {
                ForEach(ProfileGender.allCases) { profileGender in
                    Button(action: {
                        selectedGender = profileGender
                        selectedAccount.profile.gender = selectedGender
                    }) {
                        Text(profileGender.rawValue.capitalized)
                    }
                }
            }
        label: { Image(systemName: "arrow.down") }
        }
    }
    
    @ViewBuilder private var updateBirthDate: some View {
        DatePicker(LocalizedStringKey("profile_date_of_birth"), selection: $selectedAccount.profile.dateOfBirth, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
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
                try await accountsStore.updateAccountDetails(for: selectedAccount.profile, in: selectedAccount)
                isPresentingEditProfile = false
            }
        }
    }
    
    private func evaluateButtonGuardCondition(_ buttonGuardCondition: SaveEditedProfileAlert) -> Bool {
        switch buttonGuardCondition {
        case .minimumLetters:
            return selectedAccount.profile.name.count >= 2
        case .maximumLetters:
            return selectedAccount.profile.name.count <= 35
        case .role:
            return selectedAccount.profile.role != nil
        case .gender:
            return selectedAccount.profile.gender != nil
        }
    }
    
    private func createSaveEditedProfileAlert(ofType: SaveEditedProfileAlert) {
        alertMessage = NSLocalizedString(ofType.message, comment: "")
        showAlert = true
    }
}

import SwiftUI

struct RegisterScreenView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @ObservedObject var accountsStore: AccountsStore
    @State private var editingAccount = Account.emptyAccount
    @Binding var showRegistration: Bool
    
    var body: some View {
        NavigationView {
            Form {

                Section(header: Text(LocalizedStringKey("update_profile_contact_information"))) {
                    createEmail
                    createPassword
                }
                
                saveButton
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    
            }

            .navigationTitle(Text("Register"))
        }
        .navigationBarBackButtonHidden(true)
    }
  
    @ViewBuilder private var createEmail: some View {
        TextField(LocalizedStringKey("profile_email"), text: $editingAccount.email)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var createPassword: some View {
        SecureField(LocalizedStringKey("profile_password"), text: $editingAccount.password)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var saveButton: some View {
        Button(LocalizedStringKey("update_profile_save_profile")) {
//            for buttonGuardCondition in SaveAccountAlert.allCases {
//                guard evaluateButtonGuardCondition(buttonGuardCondition) else {
//                    createSaveEditedProfileAlert(ofType: buttonGuardCondition)
//                    return
//                }
//            }

            Task {
                try await accountsStore.saveAccount(_: editingAccount)
            }
            showRegistration = false
            
        }
    }

    private func evaluateButtonGuardCondition(_ buttonGuardCondition: SaveAccountAlert) -> Bool {
        switch buttonGuardCondition {
        case .minimumLetters:
            return editingAccount.password.count >= 5
        case .maximumLetters:
            return editingAccount.password.count <= 20
        case .validEmail:
            return isValidEmailAddress(emailAddress: editingAccount.email)
        }
    }

    private func createSaveEditedProfileAlert(ofType: SaveAccountAlert) {
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

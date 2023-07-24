import Foundation

class RegisterScreenViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var editingAccount = Account.emptyAccount
    
    func createAlert() {
        for buttonGuardCondition in SaveAccountAlert.allCases {
            guard evaluateButtonGuardCondition(buttonGuardCondition) else {
                createSaveEditedProfileAlert(ofType: buttonGuardCondition)
                return
            }
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

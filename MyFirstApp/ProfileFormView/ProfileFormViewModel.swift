//import Foundation
//
//class ProfileFormViewModel: ObservableObject {
//    @Published var selectedGender: ProfileGender?
//    @Published var selectedRole: ActivityRole?
//    @Published var showAlert = false
//    @Published var alertMessage = ""
//    var selectedAccount: Account
//    
//    func createAlerts() {
//        for buttonGuardCondition in SaveEditedProfileAlert.allCases {
//            guard evaluateButtonGuardCondition(buttonGuardCondition) else {
//                createSaveEditedProfileAlert(ofType: buttonGuardCondition)
//                return
//            }
//        }
//    }
//
//    private func evaluateButtonGuardCondition(_ buttonGuardCondition: SaveEditedProfileAlert) -> Bool {
//        switch buttonGuardCondition {
//        case .minimumLetters:
//            return selectedAccount.profile.name.count >= 2
//        case .maximumLetters:
//            return selectedAccount.profile.name.count <= 35
//        case .role:
//            return selectedAccount.profile.role != nil
//        case .gender:
//            return selectedAccount.profile.gender != nil
//        }
//    }
//
//    private func createSaveEditedProfileAlert(ofType: SaveEditedProfileAlert) {
//        alertMessage = NSLocalizedString(ofType.message, comment: "")
//        showAlert = true
//    }
//}

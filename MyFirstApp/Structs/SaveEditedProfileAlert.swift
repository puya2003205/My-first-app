import Foundation

enum SaveEditedProfileAlert: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case minimumLetters
    case maximumLetters
    case role
    case gender
    case validEmail
    
    var message: String {
        switch self {
        case .minimumLetters:
            return "profile_error_name_minimum_letters"
        case .maximumLetters:
            return "profile_error_name_maximum_letters"
        case .role:
            return "profile_error_role_selection"
        case .gender:
            return "profile_error_gender_selection"
        case .validEmail:
            return "profile_error_email"
        }
    }
}

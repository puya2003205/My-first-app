import Foundation

enum SaveAccountAlert: CaseIterable {
    
    case minimumLetters
    case maximumLetters
    case validEmail
    
    var message: String {
        switch self {
        case .minimumLetters:
            return "profile_error_name_minimum_letters"
        case .maximumLetters:
            return "profile_error_name_maximum_letters"
        case .validEmail:
            return "profile_error_email"
        }
    }
}

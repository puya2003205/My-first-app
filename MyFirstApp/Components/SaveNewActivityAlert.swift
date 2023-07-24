import Foundation

enum SaveNewActivityAlert: CaseIterable {
    case title
    case significance
    case duration
    
    var title: String {
        switch self {
        case .title:
            return "new_activity_title_error_title"
        case .significance:
            return "new_activity_significance_error_title"
        case .duration:
            return "new_activity_duration_error_title"
        }
    }
    
    var message: String {
        switch self {
        case .title:
            return "new_activity_title_error_message"
        case .significance:
            return "new_activity_significance_error_message"
        case .duration:
            return "new_activity_duration_error_message"
        }
    }
}

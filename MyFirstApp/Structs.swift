import Foundation

struct Profile: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var role: String
    var gender: String
    var dateOfBirth: Date
    var email: String
    
    init(id: UUID = UUID(), name: String, role: String, gender: String, dateOfBirth: Date, email: String) {
        self.id = id
        self.name = name
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.email = email
    }
}

enum ActivitySignificance: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case lower = "activity_significance_lower"
    case medium = "activity_significance_medium"
    case higher = "activity_significance_higher"
    case urgent = "activity_significance_urgent"
}

enum ActivityRole: String, Codable, CaseIterable {
    case frontend = "frontend"
    case backend = "backend"
    case devops = "devops"
    case android = "android"
    case ios = "ios"
}

struct Activity: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var significance: ActivitySignificance?
    var duration: Int
    var status: Bool
    var role: ActivityRole?
    var durationDouble: Double {
        get {
            Double(duration)
        }
        set {
            duration = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), title: String, significance: ActivitySignificance?, duration: Int, status: Bool, role: ActivityRole?) {
        self.id = id
        self.title = title
        self.significance = significance
        self.duration = duration
        self.status = status
        self.role = role
    }
}

extension Activity {
    static var emptyActivity: Activity {
        Activity(title: "", significance: nil, duration: 0, status: false, role: nil)
    }
}

struct Comment: Identifiable, Codable, Equatable {
    let id: UUID
    var comment: String
    var date: String
    var activity: Activity
    
    init(id: UUID = UUID(), comment: String, date: String, activity: Activity) {
        self.id = id
        self.comment = comment
        self.date = date
        self.activity = activity
    }
}

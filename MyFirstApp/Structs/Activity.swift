import Foundation

enum ActivitySignificance: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case lower = "activity_significance_lower"
    case medium = "activity_significance_medium"
    case higher = "activity_significance_higher"
    case urgent = "activity_significance_urgent"
}

enum ActivityRole: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
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
    
    static var emptyActivity: Activity {
        Activity(title: "", significance: nil, duration: 0, status: false, role: nil)
    }
}

enum SwipeDirection {
    case left(CGSize)
    case right(CGSize)
    case none
}

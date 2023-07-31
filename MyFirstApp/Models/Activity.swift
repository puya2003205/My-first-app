import Foundation

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
    var comments: [Comment]
    
    init(id: UUID = UUID(), title: String, significance: ActivitySignificance?, duration: Int, status: Bool, role: ActivityRole?, comments: [Comment]) {
        self.id = id
        self.title = title
        self.significance = significance
        self.duration = duration
        self.status = status
        self.role = role
        self.comments = comments
    }
    
    static var emptyActivity: Activity {
        Activity(title: "", significance: nil, duration: 0, status: false, role: nil, comments: [])
    }
    
    static var sampleData: [Activity] {[
        Activity(title: "Ios1", significance: ActivitySignificance.medium, duration: 5, status: true, role: ActivityRole.ios, comments: Comment.sampleData)
    ]}
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

enum SwipeDirection {
    case left(CGSize)
    case right(CGSize)
    case none
}

enum TabItemElement: Int, CaseIterable, Hashable {
    case favorites
    case explore
    case profile
}

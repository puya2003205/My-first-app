import Foundation

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

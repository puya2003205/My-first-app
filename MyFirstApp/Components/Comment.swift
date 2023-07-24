import Foundation

struct Comment: Identifiable, Codable, Equatable {
    let id: UUID
    var comment: String
    var date: String
    
    init(id: UUID = UUID(), comment: String, date: String) {
        self.id = id
        self.comment = comment
        self.date = date
    }
    
    static var emptyComment: Comment {
        Comment(comment: "", date: "")
    }
    
    static var sampleData: [Comment] {[
        Comment(comment: "salut", date: "10:45")
    ]}
}

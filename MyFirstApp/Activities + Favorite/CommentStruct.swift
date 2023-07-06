import Foundation

struct CommentStruct: Identifiable, Codable, Equatable {
    let id: UUID
    var comment: String
    var date: String
    
    init(id: UUID = UUID(), comment: String, date: String) {
        self.id = id
        self.comment = comment
        self.date = date
    }
}

extension CommentStruct {
    static var newComment: CommentStruct {
        CommentStruct(comment: "", date: "")
    }
}

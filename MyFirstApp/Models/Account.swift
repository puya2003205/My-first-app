import Foundation

struct Account: Identifiable, Codable, Equatable {
    let id: UUID
    var email: String
    var password: String
    var profile: Profile
    var activities: [Activity]
    var favorites: [Activity]
    var comments: [Comment]
    
    init(id: UUID = UUID(), email: String, password: String, profile: Profile, activities: [Activity], favorites: [Activity], comments: [Comment]) {
        self.id = id
        self.email = email
        self.password = password
        self.profile = profile
        self.favorites = favorites
        self.activities = activities
        self.comments = comments
    }
    
    static var emptyAccount: Account {
        Account(email: "", password: "", profile: Profile.emptyProfile, activities: [], favorites: [], comments: [])
    }
    
    static var sampleData: Account {
        Account(email: "test@test.ro", password: "test", profile: Profile.sampleData, activities: Activity.sampleData, favorites: Activity.sampleData, comments: Comment.sampleData)
    }
}

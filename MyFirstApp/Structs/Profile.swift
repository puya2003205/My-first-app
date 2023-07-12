import Foundation

enum ProfileGender: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case male = "male"
    case female = "female"
}

struct Profile: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var role: ActivityRole?
    var gender: ProfileGender?
    var dateOfBirth: Date
    var email: String
    
    init(id: UUID = UUID(), name: String, role: ActivityRole?, gender: ProfileGender?, dateOfBirth: Date, email: String) {
        self.id = id
        self.name = name
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.email = email
    }
    
    static var emptyProfile: Profile {
        Profile(name: "", role: nil, gender: nil, dateOfBirth: Date.now, email: "")
    }
}

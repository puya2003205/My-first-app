import Foundation

struct Profile: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var role: ActivityRole?
    var gender: ProfileGender?
    var dateOfBirth: Date
    
    init(id: UUID = UUID(), name: String, role: ActivityRole?, gender: ProfileGender?, dateOfBirth: Date) {
        self.id = id
        self.name = name
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
    }
    
    static var emptyProfile: Profile {
        Profile(name: "", role: nil, gender: nil, dateOfBirth: Date.now)
    }
    
    static var sampleData: Profile {
        Profile(name: "Andrei", role: ActivityRole.ios, gender: ProfileGender.male, dateOfBirth: Date.now)
    }
}

enum ProfileGender: String, Codable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case male = "male"
    case female = "female"
}

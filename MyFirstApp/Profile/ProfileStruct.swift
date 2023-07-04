import Foundation

struct ProfileStruct: Identifiable, Codable, Equatable {
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

extension ProfileStruct{
    static let sampleData: [ProfileStruct] =
    [ProfileStruct(name: "Andrei", role: "Ios Dev", gender: "Male", dateOfBirth: Date.now, email: "andrei.stanciu@idea-bank.ro")]
}


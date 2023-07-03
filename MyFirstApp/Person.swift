import Foundation

struct Person: Identifiable, Codable, Equatable{
    let id: UUID
    var nume: String
    var role: String
    var gender: String
    var dateOfBirth: Date
    var email: String
    
    init(id: UUID = UUID(), nume: String, role: String, gender: String, dateOfBirth: Date, email: String) {
        self.id = id
        self.nume = nume
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.email = email
    }
}

extension Person{
    static let sampleData: [Person] =
    [Person(nume: "Andrei", role: "Ios Dev", gender: "Male", dateOfBirth: Date.now, email: "andrei.stanciu@idea-bank.ro")]
}


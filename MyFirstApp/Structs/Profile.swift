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
    var account: Account
    
    init(id: UUID = UUID(), name: String, role: ActivityRole?, gender: ProfileGender?, dateOfBirth: Date, account: Account) {
        self.id = id
        self.name = name
        self.role = role
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.account = account
    }
    
    static var emptyProfile: Profile {
        Profile(name: "", role: nil, gender: nil, dateOfBirth: Date.now, account: Account.emptyAccount)
    }
    
    static var sampleData: Profile {
        Profile(name: "Andrei", role: ActivityRole.ios, gender: ProfileGender.male, dateOfBirth: Date.now, account: Account.sampleData)
    }
}

struct Account: Identifiable, Codable, Equatable {
    let id: UUID
    var email: String
    var password: String
    
    init(id: UUID = UUID(), email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
    
    static var emptyAccount: Account {
        Account(email: "", password: "")
    }
    
    static var sampleData: Account {
        Account(email: "andrei.stanciu@idea-bank.ro", password: "")
    }
}

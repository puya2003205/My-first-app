import Foundation

struct Activity: Identifiable, Codable, Equatable{
    let id: UUID
    var titlu: String
    var importanta: String
    var durata: Int
    var status: Bool
    var pozitie: String?
    var durataDouble: Double {
        get {
            Double(durata)
        }
        set {
            durata = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), titlu: String, importanta: String, durata: Int, status: Bool, pozitie: String) {
        self.id = id
        self.titlu = titlu
        self.importanta = importanta
        self.durata = durata
        self.status = status
        self.pozitie = pozitie
    }
}

extension Activity {
    static var emptyActivity: Activity {
        Activity(titlu: "", importanta: "", durata: 0, status: false, pozitie: "")
    }
}

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
    static let sampleData: [Activity] =
    [
        Activity(titlu: "Pucioasa1", importanta: "medie", durata: 12, status: false, pozitie: "android"),
        Activity(titlu: "Pucioasa2", importanta: "mica", durata: 11, status: true, pozitie: "android"),
        Activity(titlu: "Pucioasa3", importanta: "mare", durata: 4, status: false, pozitie: "android"),
        Activity(titlu: "Pucioasa4", importanta: "urgenta", durata: 6, status: true, pozitie: "android"),
        Activity(titlu: "Pucioasa5", importanta: "mica", durata: 19, status: false, pozitie: "android")
    ]
    
    static var emptyActivity: Activity {
        Activity(titlu: "", importanta: "", durata: 0, status: false, pozitie: "")
    }
}

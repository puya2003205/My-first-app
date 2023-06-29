import Foundation

struct Activity: Identifiable, Codable{
    let id: UUID
    var titlu: String
    var importanta: String
    var durata: Int
    var status: Bool
    var durataDouble: Double {
        get {
            Double(durata)
        }
        set {
            durata = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), titlu: String, importanta: String, durata: Int, status: Bool) {
        self.id = id
        self.titlu = titlu
        self.importanta = importanta
        self.durata = durata
        self.status = status
    }
}

extension Activity {
    static let sampleData: [Activity] =
    [
        Activity(titlu: "Pucioasa1", importanta: "medie", durata: 12, status: false),
        Activity(titlu: "Pucioasa2", importanta: "mica", durata: 11, status: true),
        Activity(titlu: "Pucioasa3", importanta: "mare", durata: 4, status: false),
        Activity(titlu: "Pucioasa4", importanta: "urgenta", durata: 6, status: true),
        Activity(titlu: "Pucioasa5", importanta: "mica", durata: 19, status: false)
    ]
    
    static var emptyActivity: Activity {
        Activity(titlu: "", importanta: "", durata: 0, status: false)
    }
}

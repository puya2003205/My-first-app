import Foundation

struct Activity: Identifiable, Codable{
    let id: UUID
    var titlu: String
    var distanta: Int
    var startHour: Int
    var status: Bool
    var distantaDouble: Double {
        get {
            Double(distanta)
        }
        set {
            distanta = Int(newValue)
        }
    }
    var startHourDouble: Double {
        get {
            Double(startHour)
        }
        set {
            startHour = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), titlu: String, distanta: Int, startHour: Int, status: Bool) {
        self.id = id
        self.titlu = titlu
        self.distanta = distanta
        self.startHour = startHour
        self.status = status
    }
}

extension Activity {
    static let sampleData: [Activity] =
    [
        Activity(titlu: "Pucioasa1", distanta: 60, startHour: 12, status: false),
        Activity(titlu: "Pucioasa2", distanta: 50, startHour: 11, status: true),
        Activity(titlu: "Pucioasa3", distanta: 40, startHour: 4, status: false),
        Activity(titlu: "Pucioasa4", distanta: 70, startHour: 6, status: true),
        Activity(titlu: "Pucioasa5", distanta: 80, startHour: 19, status: false)
    ]
    
    static var emptyActivity: Activity {
        Activity(titlu: "", distanta: 0, startHour: 0, status: false)
    }
}

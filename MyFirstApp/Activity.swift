import Foundation

struct Activity {
    let titlu: String
    let distanta: Int
    let startHour: Int
    let status: Bool
    
    init(titlu: String, distanta: Int, startHour: Int, status: Bool) {
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
}

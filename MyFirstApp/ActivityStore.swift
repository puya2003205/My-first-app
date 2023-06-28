import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activitati: [Activity] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("activitati.data")
    }
    
    func load() async throws {
        let task = Task<[Activity], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            return activities
        }
        let activitati = try await task.value
        self.activitati = activitati
    }

    func save(activitati: [Activity]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(activitati)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

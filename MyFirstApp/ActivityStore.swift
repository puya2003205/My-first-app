import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activitati: [Activity] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("activitati2.data")
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
    
    func save(activitate: Activity) async throws {
        let task = Task {
            do{
                try await load()
                activitati.append(activitate)
                let data = try JSONEncoder().encode(activitati)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            } catch {
                print(error)
            }
        }
        try await load()
        _ = await task.value
    }
    
    func updateActivityStatusTrue() {
        _ = Task {
            let fileURL = try Self.fileURL()
            let data = try Data(contentsOf: fileURL)
            var activity = try JSONDecoder().decode(Activity.self, from: data)
            activity.status = true
            let updatedData = try JSONEncoder().encode(activity)
            try updatedData.write(to: fileURL)
        }
        
    }
    
    func updateActivityStatusFalse() {
        _ = Task {
            let fileURL = try Self.fileURL()
            let data = try Data(contentsOf: fileURL)
            var activity = try JSONDecoder().decode(Activity.self, from: data)
            activity.status = false
            let updatedData = try JSONEncoder().encode(activity)
            try updatedData.write(to: fileURL)
        }
       
    }
}

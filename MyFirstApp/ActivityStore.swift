import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activitati: [Activity] = []
//    private static var name = "activitati2"
//
//    private static var filename: String {
//        return name + ".data"
//    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("taskuri.data")
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
    
    func updateActivityStatusTrue(for activity: Activity) async throws {
        Task {
            do {
                let fileURL = try Self.fileURL()
                var activities = try loadActivities()
                if let index = activities.firstIndex(where: { $0.id == activity.id }) {
                    activities[index].status = true
                    let updatedData = try JSONEncoder().encode(activities)
                    try updatedData.write(to: fileURL)
                }
            } catch {
                print(error)
            }
        }
    }

    func updateActivityStatusFalse(for activity: Activity) async throws {
        Task {
            do {
                let fileURL = try Self.fileURL()
                var activities = try loadActivities()
                if let index = activities.firstIndex(where: { $0.id == activity.id }) {
                    activities[index].status = false
                    let updatedData = try JSONEncoder().encode(activities)
                    try updatedData.write(to: fileURL)
                }
            } catch {
                print(error)
            }
        }
    }

    private func loadActivities() throws -> [Activity] {
        let fileURL = try Self.fileURL()
        guard let data = try? Data(contentsOf: fileURL) else {
            return []
        }
        let activities = try JSONDecoder().decode([Activity].self, from: data)
        return activities
    }

}



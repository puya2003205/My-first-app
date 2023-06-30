import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activitati: [Activity] = []
    @Published var favorite: [Activity] = []
    
    var name: String = "frontend"
    var filename: String {
        return name + ".data"
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(filename)
    }
    private func fileFavoriteURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("favorite.data")
    }
    
    func load() async throws {
        let task = Task<[Activity], Error> {
            let fileURL = try fileURL()
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
                let outfile = try fileURL()
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
                let fileURL = try fileURL()
                var activities = try loadActivities()
                if let index = activities.firstIndex(where: { $0.id == activity.id }) {
                    activities[index].status = true
                    let updatedData = try JSONEncoder().encode(activities)
                    try updatedData.write(to: fileURL)
                }
                try await loadFavorite()
                favorite.append(activity)
                let outfile = try fileFavoriteURL()
                let favoriteData = try JSONEncoder().encode(favorite)
                try favoriteData.write(to: outfile)
            } catch {
                print(error)
            }
        }
    }

    func updateActivityStatusFalse(for activity: Activity) async throws {
        Task {
            do {
                let fileURL = try fileURL()
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
        let fileURL = try fileURL()
        guard let data = try? Data(contentsOf: fileURL) else {
            return []
        }
        let activities = try JSONDecoder().decode([Activity].self, from: data)
        return activities
    }
    
    func loadFavorite() async throws {
        let task = Task<[Activity], Error> {
            let fileFavoriteURL = try fileFavoriteURL()
            guard let data = try? Data(contentsOf: fileFavoriteURL) else {
                return []
            }
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            return activities
        }
        let activitati = try await task.value
        self.favorite = activitati
    }
    
    func clearFavorites() async throws {
        let task = Task {
            do {
                let fileFavoriteURL = try fileFavoriteURL()
                try FileManager.default.removeItem(at: fileFavoriteURL)
                favorite = []
            } catch {
                print(error)
            }
        }
        _ = await task.value
    }
}



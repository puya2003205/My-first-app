import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activitati: [Activity] = []
    @Published var favorite: [Activity] = []
    
    // Creare nume fisisere activitati pe categorie
    var name: String = "frontend"
    var filename: String {
        return name + ".data"
    }
    
    // FileURL pentru fisierele cu activitati
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(filename)
    }
    
    // FileURL pentru fisierul cu activitatile favorite
    private func fileFavoriteURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("favorite.data")
    }
    
    // Functia load pentru incarcarea activitatilor
    func loadActivity() async throws {
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
    
    // Functia save pentru salvarea activitatilor noi
    func saveActivity(_ activitate: Activity) async throws {
        let task = Task {
            do{
                try await loadActivity()
                activitati.append(activitate)
                let data = try JSONEncoder().encode(activitati)
                let outfile = try fileURL()
                try data.write(to: outfile)
            } catch {
                print(error)
            }
        }
        try await loadActivity()
        _ = await task.value
    }
    
    // Functia care face update statusului cu valoarea "true" la swipe right
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
                let isActivityInFavorite = favorite.contains { $0.id == activity.id }
                if !isActivityInFavorite {
                    favorite.append(activity)
                    let outfile = try fileFavoriteURL()
                    let favoriteData = try JSONEncoder().encode(favorite)
                    try favoriteData.write(to: outfile)
                } 
            } catch {
                print(error)
            }
        }
    }
    
    // Functia care face update statusului cu valoarea "false" la swipe left
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
    
    // Functia loadActivities care se foloseste in update
    private func loadActivities() throws -> [Activity] {
        let fileURL = try fileURL()
        guard let data = try? Data(contentsOf: fileURL) else {
            return []
        }
        let activities = try JSONDecoder().decode([Activity].self, from: data)
        return activities
    }
    
    // Functia care da load la activitatile cu statusul true in pagina favorite
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
    
    // Functia care goleste pagina de favorite
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

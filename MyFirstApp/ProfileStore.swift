import SwiftUI

@MainActor
class ProfileStore: ObservableObject {
    @Published var profile: Profile?
    
// FileURL pentru fisierul unde este stocat profilul
    private func profileFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("profile.date")
    }
    
// Functia care incarca profilul
    func loadProfile() async throws {
        let task = Task<Profile?, Error> {
            let fileURL = try profileFileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return nil
            }
            return try JSONDecoder().decode(Profile.self, from: data)
        }
        profile = try await task.value
    }
    
// Functia care updateaza profilul
    func updateProfile(_ newProfile: Profile) async throws {
        let task = Task {
            do {
                let data = try JSONEncoder().encode(newProfile)
                let outfile = try profileFileURL()
                try data.write(to: outfile)
            } catch {
                print(error)
            }
        }
        _ = await task.value
        profile = newProfile
    }
}

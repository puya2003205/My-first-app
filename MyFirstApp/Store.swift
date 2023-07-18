import SwiftUI

@MainActor
class AccountsStore: ObservableObject {
    @Published var accounts: [Account] = []
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("accounts.data")
    }
    
    func loadAccounts() throws {
        let fileURL = try fileURL()
        guard let data = try? Data(contentsOf: fileURL) else {
            return
        }
        let decodedAccounts = try JSONDecoder().decode([Account].self, from: data)
        accounts = decodedAccounts
    }
    
    func saveAccounts() async throws {
        let fileURL = try fileURL()
        let encodedAccounts = try JSONEncoder().encode(accounts)
        try encodedAccounts.write(to: fileURL)
    }
    
    func saveAccount(_ account: Account) async throws {
        accounts.append(account)
        try await saveAccounts()
    }
    
    func updateAccountDetails(for account: Account) async throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index] = account
            try await saveAccounts()
        }
        try loadAccounts()
    }
    
    func saveNewActivity(for activity: Activity, in account: Account) async throws {
            let task = Task {
                do {
                    try loadAccounts()
                    
                    if let accountIndex = accounts.firstIndex(where: { $0.id == account.id }) {
                        accounts[accountIndex].activities.append(activity)
                        try await saveAccounts()
                    }
                } catch {
                    print(error)
                }
            }
            _ = await task.value
        }
    
    func loadComments(for activity: Activity, in account: Account) async throws {
        let task = Task<[Comment], Error> {
            let url = try fileURL(nameForDetailsFile: "\(account.id)-\(activity.id)-comments")
            guard let data = try? Data(contentsOf: url) else {
                return []
            }
            let decodedComments = try JSONDecoder().decode([Comment].self, from: data)
            return decodedComments
        }
        let comments = try await task.value
        if let accountIndex = accounts.firstIndex(where: { $0.id == account.id }),
           let activityIndex = accounts[accountIndex].activities.firstIndex(where: { $0.id == activity.id }) {
            accounts[accountIndex].activities[activityIndex].comments = comments
        }
    }
    
    func saveComment(_ comment: Comment, for activity: Activity, in account: Account) async throws {
        let task = Task {
            do {
                let url = try fileURL(nameForDetailsFile: "\(account.id)-\(activity.id)-comments")
                try await loadComments(for: activity, in: account)
                if let accountIndex = accounts.firstIndex(where: { $0.id == account.id }),
                   let activityIndex = accounts[accountIndex].activities.firstIndex(where: { $0.id == activity.id }) {
                    accounts[accountIndex].activities[activityIndex].comments.append(comment)
                    let encodedComments = try JSONEncoder().encode(accounts[accountIndex].activities[activityIndex].comments)
                    try encodedComments.write(to: url)
                }
            } catch {
                print(error)
            }
        }
        _ = await task.value
    }
    
    func updateActivityStatusTrue(for activity: Activity, in account: Account) async throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index].activities = accounts[index].activities.map { storedActivity in
                if storedActivity.id == activity.id {
                    var updatedActivity = storedActivity
                    updatedActivity.status = true
                    return updatedActivity
                } else {
                    return storedActivity
                }
            }
            try await saveAccounts()
            
            if !accounts[index].favorites.contains(where: { $0.id == activity.id }) {
                accounts[index].favorites.append(activity)
                try await saveAccounts()
            }
        }
    }
    
    func updateActivityStatusFalse(for activity: Activity, in account: Account) async throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index].activities = accounts[index].activities.map { storedActivity in
                if storedActivity.id == activity.id {
                    var updatedActivity = storedActivity
                    updatedActivity.status = false
                    return updatedActivity
                } else {
                    return storedActivity
                }
            }
            try await saveAccounts()
        }
    }

    func clearFavorites(for account: Account) async throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index].favorites = []
            try await saveAccounts()
        }
    }
    
    func clearComments(for account: Account) async throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index].comments = []
            try await saveAccounts()
        }
    }
    
    private func fileURL(nameForDetailsFile: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(nameForDetailsFile + ".data")
    }
}

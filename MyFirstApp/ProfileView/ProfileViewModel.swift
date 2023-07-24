import Foundation

class ProfileViewModel: ObservableObject {
    @Published var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @Published var showComments = false
    @Published var accountsStore: AccountsStore
    
    
}

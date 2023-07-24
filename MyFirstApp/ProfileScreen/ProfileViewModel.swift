import Foundation

class ProfileViewModel: ObservableObject {
    @Published var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @Published var showComments = false
    
    func showCommentsTrue() {
        showComments = true
    }
    
    func showCommentsFalse() {
        showComments = false
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

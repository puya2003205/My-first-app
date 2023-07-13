import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var comments: ActivityDetailStore

    var body: some View {
        if let person = profileStore.profile {
            ProfileCard(profile: person, commentsStore: comments)
        } else {
            Text("No profile found")
        }
    }
    
}

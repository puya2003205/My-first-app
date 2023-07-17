import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var commentsStore: ActivityDetailStore

    var body: some View {
        if let person = profileStore.profile {
            ProfileCard(profile: person, commentsStore: commentsStore)
        } else {
            Text("No profile found")
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let profileStore = ProfileStore()
        let commentsStore = ActivityDetailStore()
        
        ProfileView(profileStore: profileStore, commentsStore: commentsStore)
    }
}

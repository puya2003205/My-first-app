import SwiftUI

struct ProfileCard: View {
    let profile: Profile
    @ObservedObject var commentsStore: ActivityDetailStore
    @State private var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @State private var showComments = false

    var body: some View {
        VStack {
            profileGeneralDetails
            buttons
            Spacer()
            if showComments {
                AllComments(commentsStore: commentsStore)
            } else {
                profileExtendedDetails
            }
            Spacer()
        }
    }
    
    @ViewBuilder private var profileGeneralDetails: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text(profile.name)
                .font(.largeTitle)
                .foregroundColor(.black)
                .bold()
            HStack{
                Text(LocalizedStringKey("profile_role"))
                    .foregroundColor(.gray)
                Text(profile.role?.rawValue.capitalized ?? "")
            }
            .font(.title2)
        }
        .padding(.top, 30)
    }
    
    @ViewBuilder private var buttons: some View {
        HStack {
            Spacer()
            Button(action: {
                showComments = false
            }) {
                Text("Profile")
                    .frame(width: 100, height: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Spacer()
            Button(action: {
                showComments = true
                Task {
                    do {
                        try await commentsStore.loadAllComments()
                    }
                }
            }) {
                Text("Comments")
                    .frame(width: 100, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Spacer()
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder private var profileExtendedDetails: some View {
        List {
            VStack {
                Section{
                    HStack{
                        Text(LocalizedStringKey("profile_gender"))
                        Spacer()
                        Text(profile.gender?.rawValue.capitalized ?? "")
                    }
                }
            }
            VStack {
                Section{
                    HStack{
                        Text(LocalizedStringKey("profile_date_of_birth"))
                        Spacer()
                        Text(formatDate(profile.dateOfBirth))
                    }
                }
            }
            VStack {
                Section{
                    HStack{
                        Text(LocalizedStringKey("profile_email"))
                        Spacer()
                        Text(profile.email)
                    }
                }
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        let profile = Profile.sampleData
        let commentsStore = ActivityDetailStore()
        
        ProfileCard(profile: profile, commentsStore: commentsStore)
    }
}

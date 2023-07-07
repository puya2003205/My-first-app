import SwiftUI

struct ProfileCard: View {
    let profile: ProfileStruct
    @ObservedObject var commentsStore: ActivityDetailStore
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @State private var isPresentingComments = false
    var body: some View {
        VStack {
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
                    Text(profile.role)
                }
                .font(.title2)
            }
            .padding(.top, 30)
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Profile")
                        .frame(width: 100, height: 40)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                Spacer()
                Button(action: {
                    isPresentingComments = true
                    Task {
                        do {
                            try await commentsStore.loadAllComments()
                        } catch {
                            print(error)
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
            Spacer()
            List{
                VStack{
                    Section{
                        HStack{
                            Text(LocalizedStringKey("profile_gender"))
                            Spacer()
                            Text(profile.gender)
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text(LocalizedStringKey("profile_date_of_birth"))
                            Spacer()
                            Text(formatDate(profile.dateOfBirth))
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text(LocalizedStringKey("profile_email"))
                            Spacer()
                            Text(profile.email)
                        }
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isPresentingComments) {
            AllComments(commentsStore: commentsStore)
        }
    }
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct ProfileView: View {
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var comments: ActivityDetailStore

    var body: some View {
        VStack {
            if let person = profileStore.profile {
                ProfileCard(profile: person, commentsStore: comments)
            } else {
                Text("No profile found")
            }
        }

    }
}

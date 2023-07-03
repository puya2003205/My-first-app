import SwiftUI

struct ProfileCard: View {
    @State var profile: Person
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
    
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text(profile.nume)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                HStack{
                    Text("Role:")
                        .foregroundColor(.gray)
                    Text(profile.role)
                }
                .font(.title2)
            }
            .padding(.top, 30)
            Spacer()
            List{
                VStack{
                    Section{
                        HStack{
                            Text("Gender:")
                            Spacer()
                            Text(profile.gender)
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text("Date of birth:")
                            Spacer()
                            Text(formatDate(profile.dateOfBirth))
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text("Email:")
                            Spacer()
                            Text(profile.email)
                        }
                    }
                }
            }
            Spacer()
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
    @StateObject var profileStore: ActivityStore

    var body: some View {
        VStack {
            if let person = profileStore.profiles.first {
                ProfileCard(profile: person)
            } else {
                Text("No profile found")
            }
        }

    }
}

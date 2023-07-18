import SwiftUI

struct ProfileCard: View {
    var selectedAccount: Account
    @ObservedObject var accountsStore: AccountsStore
    @State private var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @State private var showComments = false
    
    var body: some View {
        VStack {
            profileGeneralDetails
            buttons
            Spacer()
            if showComments {
                AllComments(accountsStore: accountsStore, selectedAccount: selectedAccount)
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
            Text(selectedAccount.profile.name)
                .font(.largeTitle)
                .foregroundColor(.black)
                .bold()
            HStack{
                Text(LocalizedStringKey("profile_role"))
                    .foregroundColor(.gray)
                Text(selectedAccount.profile.role?.rawValue.capitalized ?? "")
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
                        Text(selectedAccount.profile.gender?.rawValue.capitalized ?? "")
                    }
                }
            }
            VStack {
                Section{
                    HStack{
                        Text(LocalizedStringKey("profile_date_of_birth"))
                        Spacer()
                        Text(formatDate(selectedAccount.profile.dateOfBirth))
                    }
                }
            }
            VStack {
                Section{
                    HStack{
                        Text(LocalizedStringKey("profile_email"))
                        Spacer()
                        Text(selectedAccount.email)
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

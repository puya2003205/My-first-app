import SwiftUI

struct ProfileView: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            profileGeneralDetails
            buttons
            Spacer()
            if viewModel.showComments {
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
                viewModel.showCommentsFalse()
            }) {
                Text("Profile")
                    .frame(width: 100, height: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Spacer()
            Button(action: {
                viewModel.showCommentsTrue()
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
                        Text(viewModel.formatDate(selectedAccount.profile.dateOfBirth))
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
}

import SwiftUI

struct LoginScreenView: View {
    @ObservedObject var activityStore: ActivityStore
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var commentsStore: ActivityDetailStore
    @State var email = ""
    @State var parola = ""
    @State private var valid = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                loginForm
                loginButton
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""), message: Text("info gresite"), dismissButton: .default(Text("OK")))
                    }
            }
            .navigationDestination(isPresented: $valid) {
                TabItem(activityStore: activityStore, profileStore: profileStore, commentsStore: commentsStore)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder private var loginForm: some View {
        Form {
            Section {
                TextField(LocalizedStringKey("profile_email"), text: $email)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField(LocalizedStringKey("profile_password"), text: $parola)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            }
            NavigationLink(destination: RegisterScreenView(profileStore: profileStore)) {
                Text("Nu am cont")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    @ViewBuilder private var loginButton: some View {
        Button {
            login()
        } label: {
            Text("Login")
                .frame(minWidth: 0, maxWidth: 100)
                .foregroundColor(.white)
                .padding(20)
                .background(.blue)
                .cornerRadius(50)
                .bold()
        }
        
    }
    
    private func login() {
        guard let profile = profileStore.profile else {
            print("error")
            return
        }
        
        if email == profile.email && parola == profile.password {
            print("succes")
            valid = true
        } else {
            print("fail")
            showAlert = true
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let activityStore = ActivityStore()
        let profileStore = ProfileStore()
        let commentsStore = ActivityDetailStore()
        
        LoginScreenView(activityStore: activityStore, profileStore: profileStore, commentsStore: commentsStore)
    }
}

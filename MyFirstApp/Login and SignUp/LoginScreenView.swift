import SwiftUI

struct LoginScreenView: View {
    @ObservedObject var accountsStore: AccountsStore
    @State var email = ""
    @State var password = ""
    @State private var valid = false
    @State private var showAlert = false
    @State private var showRegistration = false
    let goToRegister: () -> Void
    
    var body: some View {
            ZStack {
                loginForm
                loginButton
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""), message: Text("Incorrect information"), dismissButton: .default(Text("OK")))
                    }
            }
            .navigationDestination(isPresented: $valid) {
                if let matchedAccount = accountsStore.accounts.first(where: { $0.email == email && $0.password == password }) {
                    TabItem(accountsStore: accountsStore, selectedAccount: matchedAccount)
                }
            }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder private var loginForm: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            }
            Button(action: {
                goToRegister()
            }) {
                Text("Nu am cont")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    @ViewBuilder private var loginButton: some View {
        Button(action: {
            login()
        }) {
            Text("Login")
                .frame(minWidth: 0, maxWidth: 100)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.blue)
                .cornerRadius(50)
                .bold()
        }
    }
    
    private func login() {
        if accountsStore.accounts.first(where: { $0.email == email && $0.password == password }) != nil {
            print("Success")
            valid = true
        } else {
            print("Fail")
            showAlert = true
        }
    }
}

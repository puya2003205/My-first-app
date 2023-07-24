import SwiftUI

struct RegisterScreenView: View {
    @ObservedObject var accountsStore: AccountsStore
    @ObservedObject var viewModel = RegisterScreenViewModel()
    let goBackToLogin: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("update_profile_contact_information"))) {
                    createEmail
                    createPassword
                }
                
                saveButton
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
            }

            .navigationTitle(Text("Register"))
        }
        .navigationBarBackButtonHidden(true)
    }
  
    @ViewBuilder private var createEmail: some View {
        TextField(LocalizedStringKey("profile_email"), text: $viewModel.editingAccount.email)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var createPassword: some View {
        SecureField(LocalizedStringKey("profile_password"), text: $viewModel.editingAccount.password)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
    
    @ViewBuilder private var saveButton: some View {
        Button(LocalizedStringKey("update_profile_save_profile")) {
            viewModel.createAlert()
            goBackToLogin()
            Task {
                try await accountsStore.saveAccount(_: viewModel.editingAccount)
            }
        }
        
    }
}

import SwiftUI

struct HelloScreenView: View {
    @ObservedObject var accountsStore: AccountsStore
    @State private var showRegistration = false
    let goToLogin: () -> Void
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 100, alignment: .center)
                    .padding(30)
                    .background(
                        Gradient(colors: [Color(.green), Color(red: 0.4627, green: 0.8392, blue: 1.3)])
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                HStack {
                    Spacer()
                    
                    Button {
                        goToLogin()
                    } label: {
                        Text("Login")
                            .frame(minWidth: 0, maxWidth: 100)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(.blue)
                            .cornerRadius(50)
                            .bold()
                    }
                    
                    Spacer()
                    
//                    NavigationLink {
//                        RegisterScreenView(accountsStore: accountsStore, showRegistration: $showRegistration)
//                    } label: {
//                        Text("Register")
//                            .frame(minWidth: 0, maxWidth: 100)
//                            .foregroundColor(.white)
//                            .padding(20)
//                            .background(.blue)
//                            .cornerRadius(50)
//                            .bold()
//                    }
//                    Spacer()
                    
                }
                .padding(.top, 50)
            }
        .navigationBarBackButtonHidden(true)
    }
}

struct HelloScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let accountsStore = AccountsStore()
        
        HelloScreenView(accountsStore: accountsStore, goToLogin: {} )
    }
}

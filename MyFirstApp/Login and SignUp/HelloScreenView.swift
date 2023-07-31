import SwiftUI

struct HelloScreenView: View {
    @ObservedObject var accountsStore: AccountsStore
    @State private var showRegistration = false
    
    var body: some View {
        NavigationView {
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
                    
                    NavigationLink {
                        LoginScreenView(accountsStore: accountsStore)
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
                }
                .padding(.top, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HelloScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let accountsStore = AccountsStore()
        
        HelloScreenView(accountsStore: accountsStore)
    }
}

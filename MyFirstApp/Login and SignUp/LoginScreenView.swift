//
//  LoginScreenView.swift
//  MyFirstApp
//
//  Created by Andrei Stanciu on 14.07.2023.
//

import SwiftUI

struct LoginScreenView: View {
    @State var name = ""
    @State var parola = ""
    var body: some View {
        VStack {
            TextField(LocalizedStringKey("profile_email"), text: $name)
                .autocapitalization(.none)
                .autocorrectionDisabled()
            
            TextField(LocalizedStringKey("profile_email"), text: $parola)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}

//
//  SwiftUIView.swift
//  MyFirstApp
//
//  Created by Andrei Stanciu on 14.07.2023.
//

import SwiftUI

struct HelloScreenView: View {
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
                        LoginScreenView()
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
                    
                    NavigationLink {
                        RegisterScreenView()
                    } label: {
                        Text("Register")
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
    }
}

struct HelloScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HelloScreenView()
    }
}

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text("Andrei")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                HStack{
                    Text("Role:")
                    .foregroundColor(.gray)
                    Text("Ios Dev")
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
                            Text("Male")
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text("Date of birth:")
                            Spacer()
                            Text("20.05.2003")
                        }
                    }
                }
                VStack{
                    Section{
                        HStack{
                            Text("Email:")
                            Spacer()
                            Text("andrei.stanciu@idea-bank.ro")
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

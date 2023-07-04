import SwiftUI

struct ProfileFormView: View {
    @State private var nume: String = ""
    @State private var role: String = ""
    @State private var gender: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var email: String = ""
    @Binding var isPresentingEditProfile: Bool
    
    @ObservedObject var profileStore: ProfileStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $nume)
                    TextField("Role", text: $role)
                    TextField("Gender", text: $gender)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Save Profile") {
                        Task {
                           await saveProfile()
                        }
                    }
                }
            }
            .navigationBarTitle("Create Profile")
        }
    }
    
    private func saveProfile() async {
        let person = ProfileStruct(name: nume, role: role, gender: gender, dateOfBirth: dateOfBirth, email: email)
        Task {
            do {
                try await profileStore.updateProfile(person)
                isPresentingEditProfile = false
            } catch {
                print(error)
            }
        }
    }
}

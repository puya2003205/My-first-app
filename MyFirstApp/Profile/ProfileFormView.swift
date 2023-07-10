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
                Section(header: Text(LocalizedStringKey("update_profile_personal_information"))) {
                    TextField(LocalizedStringKey("update_profile_name"), text: $nume)
                    TextField(LocalizedStringKey("profile_role"), text: $role)
                    TextField(LocalizedStringKey("profile_gender"), text: $gender)
                    DatePicker(LocalizedStringKey("profile_date_of_birth"), selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text(LocalizedStringKey("update_profile_contact_information"))) {
                    TextField(LocalizedStringKey("profile_email"), text: $email)
                }
                
                Section {
                    Button(LocalizedStringKey("update_profile_save_profile")) {
                        Task {
                           await saveProfile()
                        }
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("update_profile_update_profile"))
        }
    }
    
    private func saveProfile() async {
        let person = Profile(name: nume, role: role, gender: gender, dateOfBirth: dateOfBirth, email: email)
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

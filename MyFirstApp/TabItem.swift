import SwiftUI

struct TabItem: View {
    @ObservedObject var activityStore: ActivityStore
    @ObservedObject var profileStore: ProfileStore
    @ObservedObject var commentsStore: ActivityDetailStore
    
    @State private var selectedTab = 1
    @State private var isPresentingNewActivityView = false
    @State private var selected: ActivityRole = .frontend
    @State private var isPresentingEditProfile = false
    @State private var editingProfile = Profile.emptyProfile
    
    var body: some View {
        NavigationView{
            VStack{
                if selectedTab == 1 {
                    if selected == .ios {
                        Text(selected.rawValue.uppercased())
                            .padding(.top, 20)
                            .font(.title)
                    } else {
                        Text(selected.rawValue.capitalized)
                            .padding(.top, 20)
                            .font(.title)
                    }
                }
                TabView(selection: $selectedTab) {
                    FavoritesView(activityStore: activityStore, commentsStore: commentsStore)
                        .tabItem {
                            Label("Favorites", systemImage: "star")
                        }
                        .tag(0)
                    
                    MainScreen(activityStore: activityStore)
                        .tabItem {
                            Label("Explore", systemImage: "safari.fill")
                        }
                        .tag(1)
                    
                    ProfileView(profileStore: profileStore, comments: commentsStore)
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle.fill")
                        }
                        .tag(2)
                }
                .toolbar {
                    if selectedTab == 1 {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu {
                                ForEach(ActivityRole.allCases, id: \.self) { activityRole in
                                    Button(action: { selected = activityRole
                                        activityStore.name = activityRole.rawValue
                                        Task {
                                            do {
                                                try await activityStore.loadActivity()
                                            } catch {
                                                print(error)
                                            }
                                        }
                                    }) {
                                        Label(
                                            title: {
                                                if activityRole == .ios {
                                                    Text(activityRole.rawValue.uppercased())
                                                } else {
                                                    Text(activityRole.rawValue.capitalized)
                                                }
                                            },
                                            icon: {
                                                if selected == activityRole {
                                                    Image(systemName: "checkmark.circle.fill")
                                                } else {
                                                    Image(systemName: "circle")
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                        label: {
                            Image(systemName: "arrow.up.arrow.down.circle")
                        }
                        .accessibilityLabel("Selectie")
                        .font(.system(size: 20))
                        .padding(5)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresentingNewActivityView = true
                            }) {
                                Image(systemName: "plus")
                            }
                            .accessibilityLabel("New Activity")
                            .font(.system(size: 20))
                            .padding(5)
                        }
                    }
                    if selectedTab == 0 {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                confirmationAlert()
                            }) {
                                Image(systemName: "trash.circle")
                            }
                            .accessibilityLabel("New Activity")
                            .font(.system(size: 20))
                            .padding(5)
                        }
                    }
                    if selectedTab == 2 {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresentingEditProfile = true
                                if profileStore.profile != nil {
                                    editingProfile = profileStore.profile!
                                }
                            }) {
                                Image(systemName: "square.and.pencil.circle.fill")
                            }
                            .accessibilityLabel("Edit Profile")
                            .font(.system(size: 20))
                            .padding(5)
                        }
                    }
                }
                .onChange(of: selectedTab) { tab in
                    switch tab {
                    case 0:
                        Task{
                            do {
                                try await activityStore.loadFavorite()
                            }
                        }
                    default:
                        break
                    }
                }
                .sheet(isPresented: $isPresentingNewActivityView){
                    NewActivitySheet(isPresentingNewActivity: $isPresentingNewActivityView, activityStore: activityStore, pozitie: selected.rawValue)
                }
                .sheet(isPresented: $isPresentingEditProfile) {
                    ProfileFormView(profile: $editingProfile, profileStore: profileStore, isPresentingEditProfile: $isPresentingEditProfile)
                }
            }
        }
    }
    
    func confirmationAlert() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let alertController = UIAlertController(title: "Confirmation", message: NSLocalizedString("favorites_delete_message", comment: ""), preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            Task {
                    try await activityStore.clearFavorites()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        if let window = windowScene.windows.first {
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

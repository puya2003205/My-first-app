import SwiftUI

struct FavoritesView: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    
    var body: some View {
        ScrollView {
            VStack {
                if selectedAccount.favorites.isEmpty {
                    favoriteNil
                } else {
                    ForEach(ActivityRole.allCases, id: \.self) { activityRole in
                        createSection(for: activityRole)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder private func createSection(for activityRole: ActivityRole) -> some View {
        Section(header: Text(activityRole.rawValue.capitalized)) {
            if selectedAccount.favorites.filter ({ $0.role == activityRole }).count == 0 {
                favoriteCategoryNil
            } else {
                createNavigationLink(for: activityRole)
            }
        }
    }
    
    @ViewBuilder private func createNavigationLink(for activityRole: ActivityRole) -> some View {
        ForEach(selectedAccount.favorites, id: \.title) { activity in
            if activity.role == activityRole {
                NavigationLink(destination: ActivityDetailsView(activity: activity, accountsStore: accountsStore, selectedAccount: selectedAccount)) {
                    ActivityCard(activity: activity, color: .blue)
                }
            }
        }
    }
    
    @ViewBuilder private var favoriteNil: some View {
        HStack {
            Text(LocalizedStringKey("favorites_no_activity"))
                .multilineTextAlignment(.center)
                .padding(50)
                .font(.title2)
        }
    }
    
    @ViewBuilder private var favoriteCategoryNil: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text(LocalizedStringKey("favorites_no_activity_on_category"))
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.vertical, 5)
        }
        .padding(20)
        .background(Color.blue.opacity(0.5))
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

import SwiftUI

struct MainScreen: View {
    @ObservedObject var accountsStore: AccountsStore
    var selectedAccount: Account
    var selectedRole: ActivityRole
    @State private var offset = CGSize.zero
    @State private var color: Color = .blue
    @State private var isAnimating = false
    
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(selectedAccount.activities) { activity in
                    if activity.role == selectedRole {
                        
                        
                        VStack {
                            ActivityCard(activity: activity, color: color)
                        }
                        .offset(x: offset.width, y: offset.height * 0.4)
                        .rotationEffect(.degrees(Double(offset.width / 40)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation
                                    withAnimation {
                                        changeColor(width: offset.width)
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation {
                                        let swipeDirection = determineSwipeDirection(width: offset.width)
                                        handleSwipe(swipeDirection, activity: activity)
                                        changeColor(width: offset.width)
                                    }
                                }
                        )
                    }

                }
            }
            Spacer()
        }
    }
    
    private func determineSwipeDirection(width: CGFloat) -> SwipeDirection {
        switch width {
        case -500...(-150):
            return .left(CGSize(width: -500, height: 0))
        case 150...500:
            return .right(CGSize(width: 500, height: 0))
        default:
            return .none
        }
    }
    
    private func handleSwipe(_ swipeDirection: SwipeDirection, activity: Activity) {
        switch swipeDirection {
        case .left(let offset):
            self.offset = offset
            Task {
                do {
                    try await accountsStore.updateActivityStatusFalse(for: activity, in: selectedAccount)
                } catch {
                    print(error)
                }
            }
        case .right(let offset):
            self.offset = offset
            Task {
                do {
                    try await accountsStore.updateActivityStatusTrue(for: activity, in: selectedAccount)
                } catch {
                    print(error)
                }
            }
        case .none:
            self.offset = .zero
        }
    }
    
    private func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .blue
        }
    }
}

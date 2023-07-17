import SwiftUI

struct ActivityCardWithAnimation: View {
    @ObservedObject var activityStore: ActivityStore
    var activity: Activity
    @State private var offset = CGSize.zero
    @State private var color: Color = .blue
    @State private var isAnimating = false
    
    var body: some View {
        activityCardWithAnimation
    }
    
    @ViewBuilder private var activityCardWithAnimation: some View {
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
                        handleSwipe(swipeDirection)
                        changeColor(width: offset.width)
                    }
                }
        )
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
    
    private func handleSwipe(_ swipeDirection: SwipeDirection) {
        switch swipeDirection {
        case .left(let offset):
            self.offset = offset
            Task {
                do {
                    try await activityStore.updateActivityStatusFalse(for: activity)
                    changeColor(width: offset.width)
                    try await activityStore.loadActivity()
                } catch {
                    print(error)
                }
            }
        case .right(let offset):
            self.offset = offset
            Task {
                do {
                    try await activityStore.updateActivityStatusTrue(for: activity)
                    changeColor(width: offset.width)
                    try await activityStore.loadActivity()
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

struct ActivityCardWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        let activityStore = ActivityStore()
        let activity = Activity.emptyActivity
        
        ActivityCardWithAnimation(activityStore: activityStore, activity: activity)
    }
}

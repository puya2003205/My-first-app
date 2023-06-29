import SwiftUI

struct ActivityCardWithAnimation: View {
 //   @StateObject var activityStore: ActivityStore
    var activity: Activity
    @State private var offset = CGSize.zero
    @State private var color: Color = .blue
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ActivityCard(activity: activity, color: color)
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                    
                }
                .onEnded { _ in
                    
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                        
                    }
                })
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
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

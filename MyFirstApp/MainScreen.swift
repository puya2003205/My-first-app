import SwiftUI

struct MainScreen: View {
    @State private var currentIndex = 0
    
    var body: some View {
        
            VStack {
                Text("Salut")
                    .font(.title)
                    .padding(.top, 50)
                Spacer()
                ActivityCard(activity: Activity.sampleData[currentIndex])
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                } else if value.translation.width > 0 {
                                }
                                nextCard()
                            }
                    )
                Spacer()
            }    }
    
    func nextCard() {
        if currentIndex < Activity.sampleData.count - 1 {
            currentIndex += 1
        }
    }
}


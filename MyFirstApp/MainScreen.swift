import SwiftUI

struct MainScreen: View {
    @State private var currentIndex = 0
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            Text("Salut")
                .font(.title)
                .padding(.top, 50)
            Spacer()
            ZStack{
                ForEach(0..<Activity.sampleData.count){ currentIndex in
                    ActivityCardWithAnimation(activity: Activity.sampleData[currentIndex])
                }
            }
            Spacer()
        }
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
}


import SwiftUI

struct ActivityCard: View {
    @State var activity: Activity
    @State private var offset = CGSize.zero
    var color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text("Titlu:")
                    .font(.title)
                Text(activity.titlu)
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack {
                Spacer()
                Text("Importanta:")
                    .font(.title)
                Text(activity.importanta)
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack {
                Spacer()
                Text("Durata:")
                    .font(.title)
                Text("\(activity.durata) ore")
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .padding(20)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var activity = Activity.sampleData[0]
    
    static var previews: some View {
        ActivityCard(activity: activity, color: .blue)
    }
}


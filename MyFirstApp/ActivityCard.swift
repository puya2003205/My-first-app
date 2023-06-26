import SwiftUI

struct ActivityCard: View {
    var activity: Activity
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                Text("Titlu:")
                    .font(.system(size:40))
                Text(activity.titlu)
                    .font(.system(size:30))
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                Text("Distanta:")
                    .font(.system(size:40))
                Text("\(activity.distanta) km")
                    .font(.system(size:30))
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                Text("Ora de start:")
                    .font(.system(size:40))
                Text("\(activity.startHour) am")
                    .font(.system(size:30))
                Spacer()
            }
            .padding(.bottom, 10)
        }
        
        .padding(20)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        
    }
}
struct ActivityCard_Previews: PreviewProvider {
    static var activity = Activity.sampleData[0]
    
    static var previews: some View {
        ActivityCard(activity: activity)
    }
}

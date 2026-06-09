import SwiftUI

struct AppBackground: View {
    let isMorning: Bool
    
    @ViewBuilder
    var body: some View {
        if isMorning {
            LinearGradient(
                colors: [
                    Color(red: 0.40, green: 0.72, blue: 0.98),
                    Color(red: 0.67, green: 0.85, blue: 0.98),
                    Color(red: 0.98, green: 0.88, blue: 0.65)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.04, blue: 0.18),
                    Color(red: 0.10, green: 0.08, blue: 0.30),
                    Color(red: 0.18, green: 0.06, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
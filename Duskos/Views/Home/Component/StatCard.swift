import SwiftUI

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    let textColor: Color
    let isMorning: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(textColor.opacity(0.6))
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(textColor.opacity(0.6))
                    .kerning(0.5)
            }
            Text(value)
                .font(.system(size: 28, weight: .light))
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(isMorning ? .white.opacity(0.40) : .black.opacity(0.40))
        .cornerRadius(18)
    }
}
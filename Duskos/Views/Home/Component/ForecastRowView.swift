import SwiftUI

struct ForecastRowView: View {
    let index: Int
    let day: ForecastDay
    let textColor: Color

    var body: some View {
        HStack(spacing: 12) {
            Text(dayLabel)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(textColor)
                .frame(width: 90, alignment: .leading)

            Spacer()

            AsyncImage(url: URL(string: "https:" + day.day.condition.icon)) { phase in
                if case .success(let img) = phase {
                    img.resizable().scaledToFit().frame(width: 30, height: 30)
                } else {
                    Image(systemName: "cloud.fill")
                        .foregroundColor(.gray)
                        .frame(width: 30, height: 30)
                }
            }

            Spacer()

            Text("\(Int(day.day.mintemp_c))° – \(Int(day.day.maxtemp_c))°")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(textColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
    }

    private var dayLabel: String {
        switch index {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default: return "Day After"
        }
    }
}
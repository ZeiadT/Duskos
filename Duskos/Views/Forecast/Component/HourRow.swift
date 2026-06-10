import SwiftUI

struct HourRowView: View {
    let hour: Hour
    let isFirst: Bool
    let isToday: Bool
    let textColor: Color

    var body: some View {
        HStack(spacing: 16) {
            timeLabel
            Spacer()
            weatherIcon
            Spacer()
            temperatureLabel
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }

    private var timeLabel: some View {
        let label = (isFirst && isToday)
            ? "Now"
            : DateUtil.formatHour(from: hour.time)

        return Text(label)
            .font(.system(size: 17, weight: .medium))
            .foregroundColor(textColor)
            .frame(width: 65, alignment: .leading)
    }

    private var weatherIcon: some View {
        AsyncImage(url: URL(string: "https:" + hour.condition.icon)) { phase in
            if case .success(let img) = phase {
                img.resizable().scaledToFit()
            } else {
                Image(systemName: "cloud.fill").foregroundColor(.gray)
            }
        }
        .frame(width: 36, height: 36)
    }

    private var temperatureLabel: some View {
        Text("\(Int(hour.temp_c))°")
            .font(.system(size: 22, weight: .light))
            .foregroundColor(textColor)
            .frame(width: 55, alignment: .trailing)
    }
}
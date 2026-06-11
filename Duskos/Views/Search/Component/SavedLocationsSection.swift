import SwiftUI

struct SavedLocationsSection: View {
    let locations: [SavedLocation]
    let onSelect: (SavedLocation) -> Void
    let onDelete: (IndexSet) -> Void

    var body: some View {
        Section("Saved Locations") {
            if locations.isEmpty {
                Label("No saved locations yet", systemImage: "mappin.slash")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            } else {
                ForEach(locations) { location in
                    Button { onSelect(location) } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "location.fill")
                                .foregroundColor(.blue)
                                .frame(width: 20)
                            Text(location.name)
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: onDelete)
            }
        }
    }
}
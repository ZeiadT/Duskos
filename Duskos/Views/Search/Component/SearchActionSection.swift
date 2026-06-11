import SwiftUI

struct SearchActionSection: View {
    let searchText: String
    let onSearch: () -> Void
    let onSaveAndSearch: () -> Void

    var body: some View {
        Section {
            Button(action: onSearch) {
                HStack {
                    Image(systemName: "location.magnifyingglass")
                        .foregroundColor(.blue)
                    Text("Search \"\(searchText)\"")
                        .foregroundColor(.primary)
                }
            }

            Button(action: onSaveAndSearch) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("Save & search \"\(searchText)\"")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
import SwiftUI

struct SearchBarRow: View {
    @Binding var searchText: String
    let onSubmit: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search any city...", text: $searchText)
                .disableAutocorrection(true)
                .onSubmit { onSubmit() }
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
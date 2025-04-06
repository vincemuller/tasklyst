//
//  TLListItemSortView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLListItemSortView: View {
    
    @Binding var selectedSort: StatusSort
    
    var body: some View {
        HStack {
            Spacer()
            Menu {
                Picker("", selection: $selectedSort) {
                    ForEach(StatusSort.allCases) { sortOption in
                        Text(sortOption.label)
                    }
                }
            } label: {
                HStack(spacing: 5) {
                    TLTextView(text: selectedSort.label)
                    Image(systemName: "arrow.up.and.down")
                        .foregroundStyle(Color.tasklystAccent)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    TLListItemSortView(selectedSort: .constant(.all))
}

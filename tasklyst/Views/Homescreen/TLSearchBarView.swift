//
//  TLSearchBarView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLSearchBarView: View {
    
    @Binding var searchTerms: String
    var contentWidth: CGFloat
    var contentHeight: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.tasklystSecondary)
                .stroke(.tasklystAccent)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.tasklystForeground.opacity(0.5))
                TextField("Search lists", text: $searchTerms)
                Spacer()
            }
            .padding(.leading)
        }
        .frame(width: contentWidth * 0.84, height: 40)
        .padding()
    }
}

#Preview {
    TLSearchBarView(searchTerms: .constant(""), contentWidth: 393, contentHeight: 750)
}

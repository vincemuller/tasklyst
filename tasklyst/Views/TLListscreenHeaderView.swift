//
//  TLListscreenHeaderView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLListscreenHeaderView: View {
    
    @ObservedObject var list: ListEntity
    
    var contentWidth: CGFloat = 393
    var contentHeight: CGFloat = 35
    
    var body: some View {
        TextEditor(text: Binding(
            get: { list.name ?? "" },
            set: { newValue in list.name = newValue }
        ))
            .font(.system(.title3, design: .monospaced, weight: .semibold))
            .foregroundStyle(.tasklystAccent)
            .multilineTextAlignment(.center)
            .frame(height: contentHeight)
        Rectangle()
            .fill(.tasklystAccent)
            .frame(width: contentWidth * 0.77, height: 1)
            .padding(.bottom, 10)
    }
}

#Preview {
    TLListscreenHeaderView(list: ListEntity())
}

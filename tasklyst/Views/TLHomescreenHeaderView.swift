//
//  TLHeaderView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLHomescreenHeaderView: View {
    var title: String = "tasklyst"
    var contentWidth: CGFloat = 393
    
    var body: some View {
        Text("tasklyst")
            .font(.system(.title2, design: .monospaced, weight: .semibold))
            .foregroundStyle(.tasklystAccent)
        Rectangle()
            .fill(.tasklystAccent)
            .frame(width: contentWidth * 0.77, height: 1)
    }
}

#Preview {
    TLHomescreenHeaderView()
}

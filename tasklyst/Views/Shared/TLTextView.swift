//
//  TLTextView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/5/25.
//

import SwiftUI

struct TLTextView: View {
    
    var text: String
    var color: Color = Color.tasklystAccent
    var size: CGFloat = 12
    var weight: Font.Weight = .regular
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: weight))
            .foregroundStyle(color)
    }
}

#Preview {
    TLTextView(text: "Test Text")
}

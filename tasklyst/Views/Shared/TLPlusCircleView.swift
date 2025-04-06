//
//  TLPlusCircleView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/5/25.
//

import SwiftUI

struct TLPlusCircleView: View {
    var createFunction: () -> ()
    
    var body: some View {
        Button {
            createFunction()
        } label: {
            Image(systemName: "plus.circle")
                .foregroundStyle(.tasklystAccent)
                .font(.system(size: 40, weight: .semibold))
        }
        .padding(.top)
    }
}

#Preview {
    TLPlusCircleView {
        print("Create new list item function here")
    }
}

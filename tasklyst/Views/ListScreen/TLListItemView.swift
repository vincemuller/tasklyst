//
//  ListItemView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/5/25.
//

import SwiftUI

struct TLListItemView: View {
    
    @ObservedObject var item: ListItemEntity
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            TextEditor(text: Binding(
                get: { item.itemDescription ?? "" },
                set: { newValue in item.itemDescription = newValue }
            ))
                .foregroundStyle(item.completed ? Color.tasklystForeground.opacity(0.3) : Color.tasklystForeground)
                .font(.system(size: 14))
                .focused($isFocused)
            Spacer()
            Button {
                withAnimation(.easeOut) {
                    item.completed.toggle()
                }
            } label: {
                ZStack {
                    Circle()
                        .stroke(item.completed ? .tasklystForeground.opacity(0.3) : .tasklystForeground, lineWidth: 2)
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 5)
                    item.completed ?
                    Image(systemName: "checkmark")
                        .offset(x: -2, y: -3)
                        .foregroundStyle(.green) :
                    nil
                }
            }
        }
        .onAppear {
            if (item.itemDescription == "") {
                isFocused = true
            }
        }
    }
}

#Preview {
    TLListItemView(item: ListItemEntity(), isFocused: FocusState())
}

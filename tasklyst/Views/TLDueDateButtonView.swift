//
//  TLDueDateButtonView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLDueDateButtonView: View {
    
    @ObservedObject var list: ListEntity
    @Binding var showDatePicker: Bool
    
    var body: some View {
        if let dueDate = list.dueDate {
            Button {
                showDatePicker.toggle()
            } label: {
                HStack(spacing: 0) {
                    TLTextView(text: "Due:  ")
                    Text(dueDate, style: .date)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.tasklystAccent)
                }
            }
            .popover(isPresented: $showDatePicker, attachmentAnchor: .point(.trailing)) {
                TLDueDatePopoverView(list: list, showDatePicker: $showDatePicker)
            }
        } else {
            Button {
                list.dueDate = Date()
                showDatePicker.toggle()
            } label: {
                Text("Add Due Date")
                    .font(.system(size: 12))
                    .foregroundStyle(.tasklystAccent)
            }
        }
    }
}

#Preview {
    TLDueDateButtonView(list: ListEntity(), showDatePicker: .constant(false))
}

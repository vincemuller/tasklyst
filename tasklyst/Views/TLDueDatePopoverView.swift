//
//  TLDueDatePopoverView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLDueDatePopoverView: View {
    
    @ObservedObject var list: ListEntity
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack(spacing: 0) {
             HStack {
                 Spacer()
                 Button("Remove Date") {
                     list.dueDate = nil
                     showDatePicker = false
                 }
                 .foregroundColor(.red)
                 .padding(.trailing, 15)
                 .padding(.top, 25)
             }
             DatePicker(
                 "Select Date",
                 selection: Binding(
                     get: { list.dueDate ?? Date() },
                     set: { newDate in list.dueDate = newDate }
                 ),
                 displayedComponents: .date
             )
             .datePickerStyle(.graphical)
             .padding()
         }
         .presentationDetents([.height(400)])
         .presentationDragIndicator(.automatic)
    }
}

#Preview {
    TLDueDatePopoverView(list: ListEntity(), showDatePicker: .constant(true))
}

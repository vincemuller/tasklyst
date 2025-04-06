//
//  Listscreen.swift
//  tasklyst
//
//  Created by Vince Muller on 4/1/25.
//

import SwiftUI


struct ListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var list: ListEntity
    
    @FocusState var isFocused: Bool
    @State var selectedSort: StatusSort = .all
    @State var showDatePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometryReader in
                ZStack {
                    Color.tasklystBackground
                        .ignoresSafeArea()
                    VStack {
                        TLListscreenHeaderView(list: list, contentWidth: geometryReader.size.width)
                        TLListItemSortView(selectedSort: $selectedSort)
                        TLListItemSectionView(list: list, selectedSort: $selectedSort, deleteAction: delete(at:))
                        Spacer()
                        TLPlusCircleView(createFunction: create)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if let dueDate = list.dueDate {
                        Button {
                            showDatePicker.toggle()
                        } label: {
                            HStack (spacing: 0) {
                                TLTextView(text: "Due:  ")
                                Text(dueDate, style: .date)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.tasklystAccent)
                            }
                        }
                        .popover(isPresented: $showDatePicker, attachmentAnchor: .point(.trailing)) {
                            VStack (spacing: 0) {
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
                    } else {
                        Button {
                            list.dueDate = Date()
                            showDatePicker.toggle()
                        } label: {
                            Text("Add Due Date")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.tasklystAccent)
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
        }

        .onDisappear {
            do {
                try viewContext.save()
            } catch {
                print("Failed to save: \(error.localizedDescription)")
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let listItem = list.listItemsArray[index]
            viewContext.delete(listItem)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting list: \(error.localizedDescription)")
        }
    }
    
    private func create() {
        ListItemEntity.create(in: viewContext, description: "", completed: false, list: list)
    }
    
}

#Preview {
    ListScreen(list: ListEntity())
}

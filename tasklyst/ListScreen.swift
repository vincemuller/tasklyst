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
            ZStack {
                Color.tasklystBackground
                    .ignoresSafeArea()
                VStack {
                    TextEditor(text: Binding(
                        get: { list.name ?? "" },
                        set: { newValue in list.name = newValue }
                    ))
                        .font(.system(.title3, design: .monospaced, weight: .semibold))
                        .foregroundStyle(.tasklystAccent)
                        .multilineTextAlignment(.center)
                        .frame(height: 35)
                    Rectangle()
                        .fill(.tasklystAccent)
                        .frame(width: 300, height: 1)
                        .padding(.bottom, 10)
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
                    VStack (alignment: .leading) {
                        List {
                            ForEach(list.listItemsArray.filter{$0.list?.id == list.id}, id: \.self) {item in
                                switch selectedSort {
                                case .all:
                                    TLListItemView(item: item)
                                        .listRowBackground(Color.clear)
                                        .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                                case .incomplete:
                                    if !item.completed {
                                        TLListItemView(item: item)
                                            .listRowBackground(Color.clear)
                                            .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                                    }
                                case .completed:
                                    if item.completed {
                                        TLListItemView(item: item)
                                            .listRowBackground(Color.clear)
                                            .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                                    }
                                }
                            }
                            .onDelete(perform: delete)
                        }
                        .listStyle(.plain)
                    }
                    .frame(width: 350, alignment: .leading)
                    Spacer()
                    TLPlusCircleView(createFunction: create)
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

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
                    .toolbar(content: {
                        if let dueDate = list.dueDate {
                            Button {
                                showDatePicker.toggle()
                            } label: {
                                Text(dueDate, style: .date) // Display date in a compact format
                                    .font(.system(size: 12)) // Match the Menu text size
                                    .foregroundStyle(Color.tasklystAccent)
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
                                    .datePickerStyle(.graphical) // Optional: Use a graphical calendar
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
                    })
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
                                Text(selectedSort.label)
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.tasklystAccent)
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
                                    ListItemView(item: item)
                                        .listRowBackground(Color.clear)
                                        .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                                case .incomplete:
                                    if !item.completed {
                                        ListItemView(item: item)
                                            .listRowBackground(Color.clear)
                                            .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                                    }
                                case .completed:
                                    if item.completed {
                                        ListItemView(item: item)
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
                    Button {
                        createNewListItem()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.tasklystAccent)
                            .font(.system(size: 40, weight: .semibold))
                    }
                    .padding(.top)
                }
            }
            .toolbar {
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
    
    private func createNewListItem() {
        ListItemEntity.create(in: viewContext, description: "", completed: false, list: list)
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
    
}

#Preview {
    ListScreen(list: ListEntity())
}

struct ListItemView: View {
    
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

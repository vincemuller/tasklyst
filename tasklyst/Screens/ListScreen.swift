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
    
    @FocusState private var isFocused: Bool
    @State private var selectedSort: StatusSort = .all
    @State private var showDatePicker: Bool = false
    
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
                    TLDueDateButtonView(list: list, showDatePicker: $showDatePicker)
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

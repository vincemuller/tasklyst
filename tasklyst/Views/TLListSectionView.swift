//
//  TLListSectionView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLListSectionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let toDoLists: FetchedResults<ListEntity>
    @Binding var searchTerms: String
    
    var body: some View {
        Text("My Lists")
            .font(.system(.title3, design: .monospaced, weight: .semibold))
            .foregroundStyle(.tasklystAccent)
            .frame(width: 330, alignment: .leading)
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.tasklystSecondary)
                .stroke(.tasklystAccent)
            List {
                ForEach(filteredLists(), id: \.self) { list in
                    NavigationLink(destination: ListScreen(list: list)) {
                        HStack {
                            Image(systemName: "list.bullet.circle")
                                .foregroundStyle(.tasklystAccent)
                            TLTextView(text: list.name ?? "", color: Color.tasklystForeground, size: 14)
                            Spacer()
                            TLTextView(text: list.listItemsArray.count.description, color: Color.tasklystForeground, size: 14)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                }
                .onDelete(perform: deleteAction)
            }
            .listStyle(.plain)
        }
        .frame(width: 340)
    }
    
    private func deleteAction(at offsets: IndexSet) {
        let filtered = filteredLists()
        for index in offsets {
            let list = filtered[index]
            viewContext.delete(list)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting list: \(error.localizedDescription)")
        }
    }
    
    private func filteredLists() -> [ListEntity] {
        toDoLists.filter {
            searchTerms.isEmpty || ($0.name?.localizedCaseInsensitiveContains(searchTerms) ?? false)
        }.sorted {
            ($0.created ?? .distantPast) < ($1.created ?? .distantPast)
        }
    }
}
//
//#Preview {
//    TLListSectionView(toDoLists: [])
//}

//ListSectionView(
//    toDoLists: filteredLists(),
//    listItems: listItems,
//    deleteAction: delete
//)

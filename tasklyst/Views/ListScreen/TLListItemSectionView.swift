//
//  TLListItemSectionView.swift
//  tasklyst
//
//  Created by Vince Muller on 4/6/25.
//

import SwiftUI

struct TLListItemSectionView: View {
    
    @ObservedObject var list: ListEntity
    @Binding var selectedSort: StatusSort
    var deleteAction: (IndexSet) -> ()
    
    var body: some View {
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
                .onDelete(perform: deleteAction)
            }
            .listStyle(.plain)
        }
        .frame(width: 350, alignment: .leading)
    }
}

#Preview {
    TLListItemSectionView(list: ListEntity(), selectedSort: .constant(.all)) { listItem in
        print(listItem)
    }
}

//
//  Listscreen.swift
//  tasklyst
//
//  Created by Vince Muller on 4/1/25.
//

import SwiftUI

struct ListScreen: View {
    
    @Binding var list: Lists
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.tasklystBackground
                    .ignoresSafeArea()
                VStack {
                    Text(list.name)
                        .font(.system(.title3, design: .monospaced, weight: .semibold))
                        .foregroundStyle(.tasklystAccent)
                    Rectangle()
                        .fill(.tasklystAccent)
                        .frame(width: 300, height: 1)
                        .padding(.bottom, 10)
                    VStack (alignment: .leading) {
                        List($list.listItems, id: \.id, editActions: .delete) { $list in
                            ListItemView(item: $list)
                                .listRowBackground(Color.clear)
                                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 0))
                        }
                        .listStyle(.plain)
                    }
                    .frame(width: 350, alignment: .leading)
                    Spacer()
                    Button {
                        list.listItems.append(ListItem(listDescription: "New List Item", completed: false))
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.tasklystAccent)
                            .font(.system(size: 40, weight: .semibold))
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    ListScreen(list: .constant(Lists(name: "Grocery Shopping List", listItems: [ListItem(listDescription: "Whole Milk", completed: false),ListItem(listDescription: "Loaf of Bread", completed: false),ListItem(listDescription: "Ketchup Bottle", completed: false)])))
}

struct ListItemView: View {
    
    @Binding var item: ListItem
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            TextEditor(text: $item.listDescription)
                .font(.system(size: 14))
                .focused($isFocused)
                .onSubmit {
                    isFocused.toggle()
                }
            Spacer()
            Button {
                item.completed.toggle()
            } label: {
                ZStack {
                    Circle()
                        .stroke(.tasklystForeground, lineWidth: 2)
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 5)
                    item.completed ?
                    Image(systemName: "checkmark")
                        .offset(x: -2, y: -3) :
                    nil
                }
            }
        }
    }
}

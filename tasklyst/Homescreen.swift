//
//  Homescreen.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var searchTerms: String = ""
    @State private var lists: [Lists] = [Lists(name: "Weekly Grocery List", listItems: []),
                                         Lists(name: "Disney Vacation Prep", listItems: []),
                                         Lists(name: "Weekend To Do's", listItems: []),
                                         Lists(name: "House Cleaning", listItems: []),]
    @State private var createListSheetIsPresenting: Bool = false
    @State private var newListName: String = ""
    @State private var enableDueDate: Bool = false
    @State private var newListDueDate: Date = Date.now.addingTimeInterval(0)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.tasklystBackground
                    .ignoresSafeArea()
                VStack {
                    Text("tasklyst")
                        .font(.system(.title2, design: .monospaced, weight: .semibold))
                        .foregroundStyle(.tasklystAccent)
                    Rectangle()
                        .fill(.tasklystAccent)
                        .frame(width: 300, height: 1)
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.tasklystSecondary)
                            .stroke(.tasklystAccent)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.tasklystForeground.opacity(0.5))
                            TextField("Search lists", text: $searchTerms)
                            Spacer()
                        }
                        .padding(.leading)
                    }
                    .frame(width: 330, height: 40)
                    .padding()
                    Text("My Lists")
                        .font(.system(.title3, design: .monospaced, weight: .semibold))
                        .foregroundStyle(.tasklystAccent)
                        .frame(width: 330, alignment: .leading)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.tasklystSecondary)
                            .stroke(.tasklystAccent)
                        List ($lists, id: \.id, editActions: .delete) { $list in
                                list.name.lowercased().contains(searchTerms.lowercased()) != true && !searchTerms.isEmpty ? nil :
                            NavigationLink(destination: ListScreen(list: $list)) {
                                HStack {
                                    Image(systemName: "list.bullet.circle")
                                        .foregroundStyle(.tasklystAccent)
                                    Text(list.name)
                                        .font(.system(size: 14))
                                    Spacer()
                                    Text(list.listItems.count.description)
                                        .font(.system(size: 14))
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                        }
                        .listStyle(.plain)
                    }
                    .frame(width: 340)
                    Spacer()
                    Button {
                        createListSheetIsPresenting = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.tasklystAccent)
                            .font(.system(size: 40, weight: .semibold))
                    }
                    .padding(.top)
                }
            }
        }
        .sheet(isPresented: $createListSheetIsPresenting) {
            VStack (alignment: .leading) {
                Text("Create New List")
                    .font(.system(.title3, design: .monospaced, weight: .semibold))
                    .foregroundStyle(.tasklystAccent)
                    .frame(width: 330, alignment: .leading)
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.tasklystSecondary)
                        .stroke(.tasklystAccent)
                    VStack (spacing: 20) {
                        HStack {
                            Text("List name: ")
                            TextField("Enter list name here", text: $newListName)
                                .padding(.leading)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.tasklystBackground)
                                        .frame(height: 30)
                                }
                        }
                        HStack {
                            Text("Enable Due Date: ")
                            Button {
                                enableDueDate.toggle()
                            } label: {
                                Circle()
                                    .fill(enableDueDate ? .tasklystAccent : .clear)
                                    .stroke(enableDueDate ? .clear : .tasklystForeground.opacity(0.5))
                                    .frame(width: 15, height: 15)
                            }
                            Spacer()
                            !enableDueDate ? nil :
                            DatePicker("", selection: $newListDueDate, displayedComponents: .date)
                        }.frame(height: 20)
                        Spacer()
                        Button {
                            createNewList()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.tasklystAccent)
                                Text("Create List")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .frame(height: 40)
                            .padding()
                        }
                    }
                    .padding()
                }
            }
            .padding()
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.automatic)

        }
    }
    
    private func createNewList() {
        enableDueDate ?
        lists.append(Lists(name: newListName, listItems: [], dueDate: newListDueDate)) :
        lists.append(Lists(name: newListName, listItems: []))
        
        createListSheetIsPresenting = false
        newListName = ""
        enableDueDate = false
        newListDueDate = Date.now.addingTimeInterval(0)
    }
}


#Preview {
    HomeScreen()
}

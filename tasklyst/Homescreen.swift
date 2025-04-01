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
    
    var body: some View {
        NavigationStack {
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
                            .foregroundStyle(.black.opacity(0.5))
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
                    List(lists) { list in
                        NavigationLink(destination: Text(list.name)) {
                            HStack {
                                Image(systemName: "list.bullet.circle")
                                    .foregroundStyle(.tasklystAccent)
                                Text(list.name)
                                    .font(.system(size: 14))
                                Spacer()
                                Text(list.getMockData().count.description)
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
                    print("create new list")
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

#Preview {
    HomeScreen()
}

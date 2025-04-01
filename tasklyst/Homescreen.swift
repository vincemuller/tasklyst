//
//  Homescreen.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var searchTerms: String = ""
    
    var body: some View {
        VStack {
            Text("tasklyst")
                .font(.system(.title2, design: .monospaced, weight: .semibold))
                .foregroundStyle(.accent)
            Rectangle()
                .fill(.accent)
                .frame(width: 300, height: 1)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondary))
                    .stroke(Color(.accent))
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
                    .foregroundStyle(Color(.accent))
                    .frame(width: 330, alignment: .leading)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondary))
                    .stroke(Color(.accent))
                List {
                    HStack {
                        Image(systemName: "list.bullet.circle")
                            .foregroundStyle(Color(.accent))
                        Text("Weekly Grocery List")
                            .font(.system(size: 14))
                        Spacer()
                        Text("12")
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    HStack {
                        Image(systemName: "list.bullet.circle")
                            .foregroundStyle(Color(.accent))
                        Text("Weekly Grocery List")
                            .font(.system(size: 14))
                        Spacer()
                        Text("12")
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    HStack {
                        Image(systemName: "list.bullet.circle")
                            .foregroundStyle(Color(.accent))
                        Text("Weekly Grocery List")
                            .font(.system(size: 14))
                        Spacer()
                        Text("12")
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    HStack {
                        Image(systemName: "list.bullet.circle")
                            .foregroundStyle(Color(.accent))
                        Text("Weekly Grocery List")
                            .font(.system(size: 14))
                        Spacer()
                        Text("12")
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
                    .foregroundStyle(Color(.accent))
                    .font(.system(size: 40, weight: .semibold))
            }
            .padding(.top)

        }
    }
}

#Preview {
    HomeScreen()
}

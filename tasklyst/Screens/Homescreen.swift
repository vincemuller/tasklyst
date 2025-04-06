//
//  Homescreen.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import SwiftUI
import CoreData


struct HomeScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ListEntity.name, ascending: true)]) var toDoLists: FetchedResults<ListEntity>
    
    @State private var searchTerms: String = ""
    @State private var createListSheetIsPresenting: Bool = false

    
    var body: some View {
        NavigationStack {
            GeometryReader { geometryReader in
                ZStack {
                    Color.tasklystBackground
                        .ignoresSafeArea()
                    VStack {
                        TLHomescreenHeaderView(contentWidth: geometryReader.size.width)
                        TLSearchBarView(searchTerms: $searchTerms, contentWidth: geometryReader.size.width, contentHeight: geometryReader.size.height)
                        TLListSectionView(toDoLists: toDoLists, searchTerms: $searchTerms)
                        Spacer()
                        TLPlusCircleView(createFunction: {createListSheetIsPresenting = true})
                    }
                }
            }
        }
        .sheet(isPresented: $createListSheetIsPresenting) {
            TLCreateListSheetView(createListSheetIsPresenting: $createListSheetIsPresenting)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}


#Preview {
    HomeScreen()
}

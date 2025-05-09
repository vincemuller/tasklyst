//
//  CreateListScreen.swift
//  tasklyst
//
//  Created by Vince Muller on 4/5/25.
//

import SwiftUI


struct TLCreateListSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var createListSheetIsPresenting: Bool
    @State var newListName: String = ""
    @State var enableDueDate: Bool = false
    @State var newListDueDate: Date = Date.now

    
    var body: some View {
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
                        presentationMode.wrappedValue.dismiss()
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
    
    private func createNewList() {
        enableDueDate ?
        ListEntity.create(in: viewContext, name: newListName, dueDate: newListDueDate) :
        ListEntity.create(in: viewContext, name: newListName)
        
        createListSheetIsPresenting = false
        newListName = ""
        enableDueDate = false
        newListDueDate = Date.now.addingTimeInterval(0)
    }
}
//
//#Preview {
//    CreateListSheetView(createListSheetIsPresenting: .constant(true), createNewList: {print("create new list function here")})
//}

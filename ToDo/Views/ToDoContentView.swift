//
//  ToDoContentView.swift
//  ToDo
//
//  Created by Aleksey Alyonin on 12.06.2022.
//

import SwiftUI
import RealmSwift

struct ToDoContentView: View {
    
    @ObservedResults(ToDo.self) var toDos
    
    @State private var name = ""
    @State private var searchFilter = ""
    @FocusState private var focus: Bool?
    @State var showView = false

    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("New toDo", text: $name)
                        .focused($focus, equals: true)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button {
                        let newToDo = ToDo(name: name)
                        $toDos.append(newToDo)
                        name = ""
                        focus = nil
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(name.isEmpty)
                    
                }
                List(){
//                    ForEach(toDos.sorted(byKeyPath: "completed")){ toDo in
                    ForEach(toDos.sorted(by: [
                        SortDescriptor(keyPath: "completed"),
                        SortDescriptor(keyPath: "urgency", ascending: false)
                                             ])){ toDo in
                        ToDoListRow(toDo: toDo)
                    }
                    .onDelete(perform: $toDos.remove)
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
                .searchable(
                    text: $searchFilter,
                    collection: $toDos,
                    keyPath: \.name) {
                        ForEach(toDos){ toDo in
                            Text(toDo.name)
                                .searchCompletion(toDo.name)
                        }
                    }

                VStack{
                    Button {
                        showView.toggle()
                    } label: {
                        Text("show")
                    }.sheet(isPresented: $showView) {
                        sheetView()
                    }
            }.padding()
            }
        }
        .animation(.default, value: toDos)
        .navigationTitle("ToDo")
    }
}

struct ToDoContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoContentView()
    }
}

//
//  sheetView.swift
//  ToDo
//
//  Created by Aleksey Alyonin on 13.06.2022.
//

import SwiftUI
import RealmSwift

struct sheetView: View {
    
    @ObservedResults(ToDo.self) var toDos

    var body: some View {
        List(){

            ForEach(toDos){ i in
                Text("\(i.name)")
            }.onDelete(perform: $toDos.remove)
        }
    
    }
}

struct sheetView_Previews: PreviewProvider {
    static var previews: some View {
        sheetView()
    }
}

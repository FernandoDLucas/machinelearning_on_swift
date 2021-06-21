//
//  ContentView.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import SwiftUI

struct ContentView: View {
//    @State var username: String = " "
//    @State var isEditing = false
//    @State var viewModel = ViewModel()
//    @State var structDTO : [KNNDTO] = []
    let knn = NearestNeighbors()
    let firstClass = KNNClass(points: [[1, 3], [3, 1], [4, 2], [5, 1], [5, 4]], classIdentifier: "A")

    let secondClass = KNNClass(points: [[6, 7], [7, 8], [8, 7], [9, 7], [9, 9]], classIdentifier: "B")

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(
                perform: self.calculate
            )
        
//        ScrollView(showsIndicators: false) {
//            ForEach(0..<structDTO.count+1){ index in
//                HStack{
//                    TextField(
//                        "KNN Classe Identifier",
//                        text:
//                    ) { isEditing in
//                        self.isEditing = isEditing
//                    } onCommit: {
//                    }
//                    .autocapitalization(.none)
//                    .disableAutocorrection(true)
//                    .border(Color(UIColor.separator))
//                    .foregroundColor(isEditing ? .red : .blue)
//                    Image(systemName: "plus")
//                                        .resizable()
//                                        .padding(6)
//                                        .frame(width: 24, height: 24)
//                                        .background(Color.blue)
//                                        .clipShape(Circle())
//                                        .foregroundColor(.white)
//                }
//            }
//        }

    }
    
    func calculate(){
        knn.classes = [firstClass, secondClass]
        knn.predict(data: [1,2])
        knn.showNearest(k: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

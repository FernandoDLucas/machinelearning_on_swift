//
//  ContentView.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import SwiftUI

struct ContentView: View {
    let data = IrisData()

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(
                perform: self.calculate
            )
    }
    
    func calculate(){
        let firstClass = KNNClass(points: data.setosa, classIdentifier: "Setosa")
        let secClass = KNNClass(points: data.versicolor, classIdentifier: "Versicolor")
        let thitClass = KNNClass(points: data.virginica, classIdentifier: "Virginica")
        
        let knn = NearestNeighbors(classes: [firstClass, secClass, thitClass])
        knn.predict(data: [7,3.1,0.3], metric: .euclidean)
        _ = knn.getNearest(k: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

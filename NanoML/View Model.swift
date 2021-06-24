//
//  View Model.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 24/06/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var itens: [Item]
    
    init() {
        self.itens = []
    }
    func calculate(x: Double, y: Double, z: Double){
        var result : [Item] = []
        let data = IrisData()
        let firstClass = KNNClass(points: data.setosa, classIdentifier: "Setosa")
        let secClass = KNNClass(points: data.versicolor, classIdentifier: "Versicolor")
        let thitClass = KNNClass(points: data.virginica, classIdentifier: "Virginica")
        
        let knn = KNearestNeighbors(classes: [firstClass, secClass, thitClass])
        knn.calculate(data: [x, y, z], metric: .chebyshev)
        knn.getNearest(K: 5)?.forEach({
            result.append(Item.init(name: $0.key, ocurency: $0.value))
        })
        result.sort()
        self.itens = result
    }
}

struct Item: Hashable, Comparable{
    static func < (lhs: Item, rhs: Item) -> Bool {
        rhs.ocurency < lhs.ocurency
    }
    
//    var id = UUID()
    var name: String
    var ocurency: Int
}

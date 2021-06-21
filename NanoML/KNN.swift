//
//  KNN.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import Foundation
class NearestNeighbors {
    var classes : [KNNClass] = []
    var computedDistances : [Distance] = []

    
    func predict(data: [Double]) {
        classes.forEach {
            let identifier = $0.identifier
            $0.points.forEach {
                var sum: Double = 0
                for i in 0..<$0.count{
                    sum += ($0[i] - data[i]).elevate()
                }
                let sqrt = sum.squareRoot()
                computedDistances.append(Distance(distance: sqrt, identifier: identifier))
            }
        }
        self.computedDistances.sort()
    }
    
    func showNearest(k: Int) {
        let nearestDistances = computedDistances.prefix(k)
        let counting = nearestDistances.reduce(into: [:]) { counts, distance in
            counts[distance.identifier, default: 0] += 1
        }
        print(counting)
    }
    
}

struct KNNClass{
    var points: [[Double]]
    var identifier: String
    
    init(points: [[Double]], classIdentifier: String){
        self.points = points
        self.identifier = classIdentifier
    }
}

struct Distance : Comparable{

    var distance: Double
    var identifier: String
}


extension Double {
    public func elevate() -> Double{
        return self * self
    }
}

extension Sequence where Element: Numeric{
    func sum() -> Element {reduce(0, +)}
}

extension Distance{
    static func < (lhs: Distance, rhs: Distance) -> Bool {
        return lhs.distance < rhs.distance
    }
}
